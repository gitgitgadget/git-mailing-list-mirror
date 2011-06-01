From: "Nori, Sekhar" <nsekhar@ti.com>
Subject: RE: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Date: Wed, 1 Jun 2011 23:57:25 +0530
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB593024D2D22DE@dbde02.ent.ti.com>
References: <1306917751-27999-1-git-send-email-nsekhar@ti.com>
 <7voc2hh3t5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRq8s-00042b-4G
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 20:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab1FAS1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 14:27:37 -0400
Received: from comal.ext.ti.com ([198.47.26.152]:57366 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753103Ab1FAS1g convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2011 14:27:36 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id p51IRSVQ018287
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Jun 2011 13:27:31 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id p51IRRU6007400;
	Wed, 1 Jun 2011 23:57:28 +0530 (IST)
Received: from dbde02.ent.ti.com ([172.24.170.145]) by dbde70.ent.ti.com
 ([172.24.170.148]) with mapi; Wed, 1 Jun 2011 23:57:27 +0530
Thread-Topic: [PATCH 1/1] git-am: provide configuration to enable signoff by
 default
Thread-Index: Acwgf2R/8Qk59lYiQ+Cz2pV34XQPVwAAkYrg
In-Reply-To: <7voc2hh3t5.fsf@alter.siamese.dyndns.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174889>

Hi Junio,

On Wed, Jun 01, 2011 at 22:44:30, Junio C Hamano wrote:
> Sekhar Nori <nsekhar@ti.com> writes:
> 
> > +am.signoff::
> > +	A boolean value which lets you enable the `-s/--signoff` option of
> > +	am by default. *Note:* Adding the Signed-off-by: line to a patch
> > +	should be a conscious act and means that you certify you have
> > +	the rights to submit this work under the same open source license.
> > +	Please see the 'SubmittingPatches' document for further discussion.
> 
> I see you already have done your homework, which is much better than
> previous attempts by other people to add an option to add sign-off to
> various commands (commit and format-patch), but there are at least three
> problems here:

Yes, I guessed there would have been previous attempts at this
and actually did search the mail archives a bit before sending
the patch. I actually didn't hit anything so looks like I probably
used the wrong keywords.

>  * This is an end-user document, not a document for git developers, so
>    they are not bound by SubmittingPatches at all. They do not necessarily
>    have SubmittingPatches document in the first place;

I will be honest here, I just took this note from the existing documentation 
for format.signoff config option. May be I can instead say: "Please check the 
guidelines on submitting patches for your project for further discussion on 
this. 'SubmittingPatches' document in Linux kernel or 'git' sources is an 
example of such a document."

>  * Once you set this configuration variable, I do not see a way to
>    countermand "This is not signed-off" from the command line for a single
>    invocation of "am" in your patch;

Okay. I guess adding an --no-signoff to git am should help here?

> 
>  * If it should be a "conscious act", it shouldn't be "set once and forget
>    about it" configuration option. You should be making the conscious
>    decision for each piece of e-mail if it is in line with the project's
>    Sign-off policy.
> 
> The last one means that the patch is internally inconsistent. In a project
> (not this project) where sign-off is used but it does not require signing
> off to be a conscious act, I see it may make sense to make it easier to
> sign-off a patch when generating (i.e. "commit -s"), preparing to send
> (i.e. "format-patch -s"), or accepting (i.e. "am -s"). And this option
> might be a possible way to do so. But in that case, the option description
> wouldn't say "it should be a conscious act".
> 
> Also if it doesn't have to be a conscious act, what value does such a
> boilerplate have? Such a project may be better off not using sign-off at
> all to begin with.

Its hard to argue against this. All I would say is it is probably
much safer to enable sign off by default when accepting a patch
than when preparing to send it. Yet, we have format.signoff but
no am.signoff. On any project with conscious sign-off rules, one
would never accept a patch without a sign-off from the original
developer.

So, just making it easier to accept patches which are already
signed-off should be okay, I guess? May be we should look for
an existing sign-off in the mbox and only then have this option
come into play?

Thanks,
Sekhar
