From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 15:24:12 -0400
Message-ID: <006401d09e32$dfc29890$9f47c9b0$@nexbridge.com>
References: <loom.20150603T104534-909@post.gmane.org> <20150603090654.GD32000@peff.net> <loom.20150603T110826-777@post.gmane.org> <20150603093514.GF32000@peff.net> <xmqqlhg0y9xj.fsf@gitster.dls.corp.google.com> <20150603190616.GA28488@peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Ed Avis'" <eda@waniasset.com>, <git@vger.kernel.org>
To: "'Jeff King'" <peff@peff.net>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 21:25:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0EH2-0004jU-7B
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 21:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbbFCTYU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 15:24:20 -0400
Received: from elephants.elehost.com ([216.66.27.132]:28954 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756362AbbFCTYT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Jun 2015 15:24:19 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t53JOD7D075363
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2015 15:24:13 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <20150603190616.GA28488@peff.net>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFyrraQjGmtUr2vpXILQHIThAtgLQIf/ulTAYu9CKgCESeLnQGnOVraAcy+bFSeDX5hQA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270727>

On June 3, 2015 3:06 PM Jeff King wrote:
> On Wed, Jun 03, 2015 at 10:32:40AM -0700, Junio C Hamano wrote:
> > "git checkout $paths" (and you can give "." for $paths to mean
> > "everything") is akin to "cp -R $elsewhere/$path ." to restore the
> > working tree copies from somewhere else.
> >
> > "Ouch, 'git checkout .'  overwrote what was in my working tree" is
> > exactly the same kind of confusion as "I ran 'cp -r ../saved .' and it
> > overwrote everything".  As you said in your initial response, that is
> > what the command is meant for.
> >
> > What does that similar command outside world, "cp", have for "more
> > safety"?  'cp -i' asks if the user wants to overwrite a file for each
> > path; perhaps a behaviour similar to that was the original poster
> > wanted to see?
> 
> Yeah, I'd say "cp -i" is the closest thing. I don't have a problem with adding that,
> but I'd really hate for it to be the default (just as I find distros which "alias
> rm='rm -i" annoying).

Brainstorming a few compromises:

or some such config option to turn on behaviour like this:
core.checkout=-i

or some such thing where if there are strictly more than m files being touched and strictly less than n files to act accordingly - a threshold concept:
core.checkout_warn_upperlimit=n # default to 0
core.checkout_warn_lowerlimit=m # default to 0

or in a more gross fashion provide a pre-checkout hook to do all the work of prompting/control of the situation.

Personally I'm happy with the defaults as they are (and was not a fan of defaulting rm -i or cp -i either) but I can see the point and have had diffuse whines from my team on the checkout subject, which is why I'm commenting.
