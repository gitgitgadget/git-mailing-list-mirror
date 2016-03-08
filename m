From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable clone
Date: Tue, 08 Mar 2016 09:07:00 -0800
Message-ID: <xmqq4mcgnbkb.fsf@gitster.mtv.corp.google.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
	<CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Kevin Wern <kevin.m.wern@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 18:07:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adL6E-0000tZ-Iv
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 18:07:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbcCHRHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 12:07:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63848 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752039AbcCHRHF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 12:07:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1FF3A4A23F;
	Tue,  8 Mar 2016 12:07:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ajzi5UwDB9Lyf62LKnjdLVlL56M=; b=egVujy
	gTsANSFdoHAFxX6wel05uZBr0NMVYB5NW9EeBghb52W70YrXS82E5KiuCqo7bHf4
	FvFkMbEjfdxG3Wu/wnKMzweYEcNOo2rOSVpBP9JNETqPs6I8ey16UMfgIEhlH6H6
	SZYpma68zzgFKFpB1krFYHT71C/W/VRmWJCcM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iVAb/8tYGQXuaW84MBfmvMlBzeCbcvkc
	fzuxkc06y7UPbDGte+wfG+eYWXfuXCqBkZ0kc2OXQzoyC5Zi8uuwA342KC7Vp7/A
	FHd0Wck9WZSV/f3LLS4QX8VQm0ZRk0nnsCC4wTSm3DTVtheGwGL9y692BZYTtB6e
	ucjLGPypmFo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 159894A23E;
	Tue,  8 Mar 2016 12:07:03 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1901A4A23A;
	Tue,  8 Mar 2016 12:07:02 -0500 (EST)
In-Reply-To: <CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
	(Kevin Wern's message of "Mon, 7 Mar 2016 19:33:40 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D156BF8-E550-11E5-9967-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288440>

Kevin Wern <kevin.m.wern@gmail.com> writes:

> From what I understand, a pattern exists in clone to download a
> packfile when a desired object isn't found as a resource. In this
> case, if no alternative is listed in http-alternatives, the client
> automatically checks the pack index(es) to see which packfile contains
> the object it needs.

You sound as if you are describing how a fetch over the dumb commit
walker http transport works.  That does not have anything to do with
the discussion of resumable clone, though, so I am not sure where
you are going with this.

> What I believe *doesn't* exist is a
> way for the server to say, "I have a resource, in this case a
> full-history packfile, and I *prefer* you get that file instead of
> attempting to traverse the object tree." This should be implemented in
> a way that is extensible to other resource types moving forward.

Yes, that is very close to what I said in the "what remains?"
section, but with a crucial difference in a detail.  Perhaps reading
the message you are respoinding to again more carefully will clear
the confusion.  This is what we want to allow the server to say
(from the message you are responding to, but rephrased slightly,
hoping that it would help unconfuse you):

    I prefer not to serve a full clone to you in the usual route if
    I can avoid it.  You can help me by populate your history first
    with something else (which would bring you to a state as if you
    cloned potentially a bit older version of me) and then coming
    back to me for an additional fetch to complete the history.

That "something else" does not have to be, and is not expected to
be, the "full" history of the current state.  As long as it can be
used to bring the cloner to a reasonably recent state, sufficient to
make a follow up incremental fetch inexpesive enough, it is
appropriate.

> I'm not sure how the server should determine the returned resource. A
> packfile alone does not guarantee the full repo history, and I'm not
> positive checking the idx file for HEAD's commit hash ensures every
> sub-object is in that file (though I feel it should, because it is
> delta-compressed).

The above reasoning does not make much technical sense.  delta
compression does not ensure connectivity in the commit history and
commit->tree->blob containment.  Again I am not sure where you are
going with this.

> With that in mind, my best guess at the server
> logic for packfiles is something like:
>
> Do I have a full history packfile, and am I configured to return one?
> - If yes, then return an answer specifying the file url and type (packfile)
> - Otherwise, return some other answer indicating the client must go
> through the original cloning process (or possibly return a different
> kind of file and type, once we expand that capability)

Roughly speaking, yes.

> Which leaves me with questions on how to test the above condition. Is
> there an expected place, such as config, where the user will specify
> the type of alternate resource, and should we assume some default if
> it isn't specified? Can the user optionally specify the exact file to
> use (I can't see why because it only invites more errors)? Should the
> specification of this option change git's behavior on update, such as
> making sure the full history is compressed? Does the existence of the
> HEAD object in the packfile ensure the repo's entire history is
> contained in that file?

Those (except for your assumption that no follow-up fetch is
allowed, which requires you to limit yourself to "full" history,
which is an unnecessary requirement) are good points one should be
making design decisions on when building this part of the system.
