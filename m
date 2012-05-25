From: roucherj <roucherj@telesun.imag.fr>
Subject: Re: credential-helpers + remote-helper, starting  =?UTF-8?Q?=20point=3F?=
Date: Fri, 25 May 2012 15:28:39 +0200
Message-ID: <5edbcd2530e49e719129f799f8c78dd3@telesun.imag.fr>
References: <b13df32797edbe8f71c796dbb4dc06a5@telesun.imag.fr>
 <20120524182110.GE3161@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <matthieu.moy@imag.fr>,
	<kim-thuat.nguyen@ensimag.fr>, <pavel.volek@ensimag.fr>,
	<javier.roucher-iglesias@ensimag.fr>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 25 15:28:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXuZa-0005ma-BC
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 15:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752617Ab2EYN2t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 May 2012 09:28:49 -0400
Received: from mx2.imag.fr ([129.88.30.17]:50106 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752430Ab2EYN2s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 May 2012 09:28:48 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id q4PDKXR9012190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 25 May 2012 15:20:33 +0200
Received: from web-ensimag.imag.fr (web-ensimag [195.221.228.24])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id q4PDSeYD011508;
	Fri, 25 May 2012 15:28:40 +0200
Received: from web-ensimag.imag.fr (localhost [127.0.0.1])
	by web-ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens) with ESMTP id q4PDSeWI026325;
	Fri, 25 May 2012 15:28:40 +0200
Received: (from apache@localhost)
	by web-ensimag.imag.fr (8.13.8/8.13.8/Submit) id q4PDSdAp026324;
	Fri, 25 May 2012 15:28:39 +0200
X-Authentication-Warning: web-ensimag.imag.fr: apache set sender to roucherj@telesun.imag.fr using -f
In-Reply-To: <20120524182110.GE3161@sigill.intra.peff.net>
X-Sender: roucherj@telesun.imag.fr
User-Agent: Roundcube Webmail/0.5.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 25 May 2012 15:20:34 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q4PDKXR9012190
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: roucherj@telesun.imag.fr
MailScanner-NULL-Check: 1338556836.60784@66fs8cEgivs9ciWs7yVSjw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198476>

On Thu, 24 May 2012 14:21:10 -0400, Jeff King wrote:
> On Thu, May 24, 2012 at 05:14:35PM +0200, roucherj wrote:
>
>> I want to know if anyone can help me with git-credential-helpers we
>> are trying to use git-credential-helpers in the git-mediawiki
>> (implemented as a remote-helper).
>> We need to ask for the login/pass of the wiki and it would be nice 
>> if
>> we can use credential-helpers to manage this credentials.
>
> Yeah, I think it makes sense to use the credential-helpers.
>
>> Anyone can send me a starting point, like a url with the
>> documentation of git-credential-helpers?
>
> Try:
>
>
> 
> https://github.com/git/git/blob/master/Documentation/technical/api-credentials.txt
>
> But that is the C API, and I assume you are building on the existing
> mediawiki helper that is written in perl. So I think what you really
> want is a "git credential" command that will let scripts hook into 
> the
> credential API. Something like:
>
>   $ git credential get https://example.com
>   username=bob
>   password=secret
>
>   $ cat <<\EOF | git credential store https://example.com
>   username=bob
>   password=secret
>   EOF
>
>   $ cat <<\EOF | git credential erase https://example.com
>   username=bob
>   password=secret
>   EOF
>
> I had planned eventually to do something like this for git-svn, but
> realized that it was more sane to just let svn library handle the
> credential storage.
>
> Do you guys want to try writing "git credential" as above? It might 
> be a
> fun side project, but I know you are also on a limited timeframe for
> your project. I can work on it if you don't have time.
>
> -Peff

Jeff thanks you for helping me with use credentials-helpers with 
git-remote
I will try to code your proposed solution.
making something like that:

+-----+ -----> +----------------------+
| git |  pipe  | git-remote-mediawiki |
+-----+ <----- +----------------------+
                      /\      ||
                      || pipe ||
                      ||      \/
                  +----------------+ ----->  O
                  | git-credential | <----- -|-
                  +----------------+        / \
                      /\      ||            User
                      || pipe ||
                      ||      \/
                  +-------------------------+
                  | git-credentials-helpers |
                  +-------------------------+
