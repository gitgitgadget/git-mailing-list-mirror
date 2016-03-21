From: Laurent Arnoud <laurent@spkdev.net>
Subject: Re: [PATCH v2] Add the tag.gpgsign option to sign all created tags
Date: Mon, 21 Mar 2016 20:29:04 +0100
Message-ID: <20160321192904.GC20083@spk-laptop>
References: <20160319182310.GA23124@spk-laptop>
 <20160320042912.GD18312@sigill.intra.peff.net>
 <20160320150703.GB5139@spk-laptop>
 <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:29:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5Vt-0007cn-11
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:29:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756407AbcCUT3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 15:29:12 -0400
Received: from ns3268618.ip-5-39-81.eu ([5.39.81.144]:33997 "EHLO
	mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755699AbcCUT3L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 15:29:11 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.spkdev.net (Postfix) with ESMTPSA id 77D04FF016;
	Mon, 21 Mar 2016 19:29:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <xmqq7fgwnzuv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289441>

On Sun, Mar 20, 2016 at 10:50:48PM -0700, Junio C Hamano wrote:
> > The `tag.gpgsign` config option allows to sign all
> > commits automatically.
> 
> I presume that you meant "all annotated tags" here.  But I am not
> sure it this is sensible.

Yes its a mistake.

> > Support `--no-sign` option to countermand configuration `tag.gpgsign`.
> So I do not see why you need a new --no-sign option at all.  If
> you have the configuration and you do want to create an unsigned
> annotated tag one-shot, all you need is to explicitly ask for "-a"
> i.e.
> 
>     $ git tag -a -m "my message" v1.0
> 
> isn't it?

You know that when you have sign configuration enabled globally annotate is
implicite, so its difficult to join both world. I use same idea as in your
patch `55ca3f99ae4895605a348322dd2fc50f2065f508`.

> If you are forcing users to always leave a message and then further
> forcing users to always sign with the single new configuration, i.e.
> 
>     $ git tag v1.0
>     ... opens the editor to ask for a message ...
>     ... then makes the user sign with GPG ...

I'm not forcing this type of user to enable global configuration, that will be
annoying for them of course.
I tried to fix a need I have currently and this is a good compromise for me.

> then I would first have to say that is a bad idea.
> 
> I can sort-of understand (but do not necessarily agree that it is a
> good idea) adding new two configurations, i.e.
> 
>  - "even without -a/-s, force the user to annotate the tag" is one
>    configuration, and
> 
>  - "even when the user did not say -s, force the user to sign an
>    annotated tag" is the other.
> 
> And with such a system, I can see why you would need an option
> "--lightweight" to force creation of a light-weight tag (i.e. to
> countermand the first one).  You can view this new option as
> something that sits next to existing -a/-s.  The current system lets
> user choose among the three variants (lightweight, annotated and
> signed) by not giving any, giving -a, and giving -s option
> respectively, but with the "--lightweight" option, the user can ask
> for one of the three explicitly, as opposed to using "lack of either
> -a/-s" as a signal to create lightweight one.
> 
> And in the context of such a system, "--no-sign" may make sense to
> override the second configuration (i.e. "force the user to sign an
> annotated tag").
> 
> But otherwise, adding only "--no-sign" does not make much sense to
> me, as it implies "not signing always means annotated", which is not
> true.  It is unclear between lightweight and annotated which one the
> user who says "--no-sign" really wants.

As I said it's difficult to easily join both world, as you know with
configuration and command line options. This is an override and if its really a
no go for this patch without refactoring this I will stop my work on it.

Just let me know I will send a patch v3 updated with tests after this.

Cheers,

-- 
Laurent
