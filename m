From: Benny Halevy <bhalevy@panasas.com>
Subject: Re: git rebase + fuzz = possible bad merge
Date: Mon, 23 Mar 2009 17:36:24 +0200
Message-ID: <49C7AC78.5070801@panasas.com>
References: <49C7675E.9000309@panasas.com> <200903231454.48600.trast@student.ethz.ch> <49C79780.20105@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Mar 23 16:39:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlmF1-0005r3-LZ
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 16:39:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbZCWPgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 11:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752244AbZCWPgc
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 11:36:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.27]:17773 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751660AbZCWPgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 11:36:31 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1775227qwh.37
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 08:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=QEALW3Y5DsGFu4IjZGKonoW1AsHyRkWVH6S+toKubq8=;
        b=xZCmwwB7ul6j7Loc/pTWGDuYtwpjvpht5OrFSpAoSzm7Y0b3PZgCUfs1AtKkstN8Vd
         NTGwLVDnetJ18Pbf2ktDzrRuC9fcWUH7X0DBrfpleZBgGA0P0Z+mVj0B9k8lVFNl6f6w
         i182mBDUC8S+1HKVqFJjFXEbrKybkTljCl5dA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=rR4lkxa+HhC/tIx69Fwz5N1E3RQgRdTMyjdDL24qc7j2rZYDYy+c8iBkToYvZOmZyO
         rYZIw9an5VcOGSQiJPDVZEg15b+3yqf0ukZaPr3vBcNPPNyLEnnrUbO6cHBZwb0yUmnk
         9msHMAmUZzi7xAcl3gexiNMLZbJP3bhkVvI68=
Received: by 10.220.87.18 with SMTP id u18mr2531423vcl.102.1237822588675;
        Mon, 23 Mar 2009 08:36:28 -0700 (PDT)
Received: from fs1.bhalevy.com (DSL212-235-53-3.bb.netvision.net.il [212.235.53.3])
        by mx.google.com with ESMTPS id 4sm8202082yxq.43.2009.03.23.08.36.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 08:36:27 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.1b3pre) Gecko/20090223 Thunderbird/3.0b2
In-Reply-To: <49C79780.20105@panasas.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114326>

On Mar. 23, 2009, 16:06 +0200, Benny Halevy <bhalevy@panasas.com> wrote:
> On Mar. 23, 2009, 15:54 +0200, Thomas Rast <trast@student.ethz.ch> wrote:
>> Benny Halevy wrote:
>>> I'm hitting bad merges with (non interactive) git rebase
>>> when a hunk is merged pre-maturely into an inexact match
>>> when there's fuzz.
>> [...]
>>> { for i in {1..10}; do echo fuzz $i; done; echo; cat test_file; } > fuzz_file
>> [...]
>>> git rebase --onto test_branch master^ master
>> git-am, and by extension rebase, by default doesn't take history into
>> account.  It just applies the patches "blindly".  ...

git am, in contrast to git rebase, errs on fuzz and you'll need to
apply the patch manually.  It might be annoying, but it'd be safer
if git rebase would either stop on fuzz too or revert to using
merge strategies (same as using git rebase -m) by default.

>> ...  Thus, there's no way
>> to know which series of 'line N' you really wanted it to go onto.

Well, there's the hunk header.

Benny

>>
>> To avoid this issue, use the -m option to git-rebase so that it uses a
>> "real" merge.  (You can achieve similar effects for git-am with the -3
>> option.)
>>
> 
> OK. -m indeed helps and I'm certainly going to adopt it for my rebase scripts.
> git rebase -i does too, BTW.
> 
> I would expect though that the default mode for automatic rebase would be
> the strictest and safest...
> 
> Benny
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
