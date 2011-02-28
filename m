From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-grep to operate across who repository and not just CWD?
Date: Mon, 28 Feb 2011 10:38:28 -0800
Message-ID: <7vd3mchumz.fsf@alter.siamese.dyndns.org>
References: <AANLkTimnOSzF1o-fX-n7b26Qx2aLP3aU3pTMGY_f5hKy@mail.gmail.com>
 <4D6B6A8B.20709@drmicha.warpmail.net>
 <AANLkTimJWeZLJbPndTyE0EUW3R9EC=yV55jhHbpZnnJn@mail.gmail.com>
 <7vk4gkhuw4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	David Chanters <david.chanters@googlemail.com>,
	git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 19:38:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu7zc-0004I8-ST
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 19:38:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754612Ab1B1Sin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 13:38:43 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753457Ab1B1Sil (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 13:38:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 01EBD4F82;
	Mon, 28 Feb 2011 13:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eynaI/J7ZVqIWFXONzpeQxih7tE=; b=Iy/I3L
	hSM6O6iYJoYymvCXUxXu6hTMFJKNneVz+0y1bXDLmA2WZ1k6WgCg1y9SkA+2D229
	u+qfFetfk3isJsy2/ME+af9g+jD8s0DU3DnzYys0oMHlk9cPK9lCd/QFMaz7WrV3
	0m9G9tRUWdpGAFgffC/BpoVdIURXw/CnZb2yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IIw6O0Jfd8kqfnstHbiTIgPE7JNW9qUe
	fVSSHS+cGERpaEU54BqJZ9pjTHRZAHSIt/owRvrH0zyr2IiYzrIvFnuYPK9XvW/S
	kmcfZU8UNSPaACBKR+ywInY6nxDImQwBV577GTQriyPUQvS8qHt1chwJ6pMkffRz
	1X9rzRshTvY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6A874F7F;
	Mon, 28 Feb 2011 13:39:53 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 544514F6E; Mon, 28 Feb 2011
 13:39:48 -0500 (EST)
In-Reply-To: <7vk4gkhuw4.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 28 Feb 2011 10\:32\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 21FF65A8-436A-11E0-953D-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168132>

Junio C Hamano <gitster@pobox.com> writes:

> Jay Soffian <jaysoffian@gmail.com> writes:
>
>> I had the crazy thought that if git had a --cdup option, then this
>> would work with any command you wanted to run from the top:
>>
>>   git --cdup grep ...
>>
>> Maybe that's the best way to expose "from the top please" generically?
>
> We tend to give --full-tree option to individual subcommands where it
> makes sense to get the same effect.
>
> One problem with a global "git --cdup" is ...

Having said all that, here is a tip of the day.  I have this in my .bashrc
for interactive shells.

        cdup () {
                local eh
                eh=$(git rev-parse --is-inside-work-tree) || return
                case "$eh" in
                true)
                        eh=$(git rev-parse --show-toplevel)
                        test -z "$eh" || cd "$eh"
                        ;;
                false)
                        eh=$(git rev-parse --git-dir) || return
                        cd "$eh" || return
                        eh=$(git rev-parse --is-bare-repository) || return
                        test "z$eh" = ztrue || cd ..
                        ;;
                esac
        }

and I can say

	$ cd Documentation/howto
        $ editor *.txt
        $ cdup

to come back to the toplevel after having worked somewhere deep in the
mine.
