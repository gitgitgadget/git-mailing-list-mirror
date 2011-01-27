From: Junio C Hamano <gitster@pobox.com>
Subject: Re: help understanding git diff output
Date: Thu, 27 Jan 2011 15:05:22 -0800
Message-ID: <7vk4hqgd71.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=H1LuGfQC8+u83So+6XyOqJxHJ3zsdgs4JTdkc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eugene Sajine <euguess@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 28 00:05:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PiauG-00030y-9i
	for gcvg-git-2@lo.gmane.org; Fri, 28 Jan 2011 00:05:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753802Ab1A0XFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jan 2011 18:05:31 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:63155 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751734Ab1A0XFa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jan 2011 18:05:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5FE66335B;
	Thu, 27 Jan 2011 18:06:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hi203Ul/AZbXnzgyMh3LJsIxki8=; b=kSy3+7
	FYhoy6zZSEAyPjobopGG6SgsP/BFm5jnlYGcatZBf8zxRFPOq6h6FdzD+5qVfJCc
	yBWrB24j7MQgjs7gbtOTTGkm0noiBvqYspaooDApqtazs5DEhd2iwcrIBgngaMbd
	A/yUc3g5wsyefxYco+iA6jWwT6gTQqixeloS4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EGDeDF69HCWbzsRoqeiVSjsRjUw83VGO
	+GDvGQK6qTluUxUYDMjvxEEHyi3lR+qvWRzRLquuK0ofbaHgJttZSC6OkyVlcho1
	FEoforbcvyl0VbT6LyXqGawXJzSt5LemLhSFcnSzmDjVUIVf9ATwPELH7pB/ZTsA
	BGU5Tr7ekag=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3C9CE335A;
	Thu, 27 Jan 2011 18:06:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4B7863359; Thu, 27 Jan 2011
 18:06:14 -0500 (EST)
In-Reply-To: <AANLkTi=H1LuGfQC8+u83So+6XyOqJxHJ3zsdgs4JTdkc@mail.gmail.com>
 (Eugene Sajine's message of "Thu\, 27 Jan 2011 17\:11\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0BB03A7A-2A6A-11E0-930F-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165594>

Eugene Sajine <euguess@gmail.com> writes:

> I get empty diff when i execute:
>
> $git diff branch1..branch2
>
> and i also get empty diff when running
>
> $git diff branch2..branch1

The thing is, "diff" is about comparing "two endpoints".

We still do support, as a backward compatibility measure, the A..B
notation to help people who learned "git diff" from ancient documents, and
we don't plan to deprecate the notation in any way, but don't be fooled by
the notation which usually means "the range from A to B".  In the context
of diff, it does not mean a range, as diff is about two "endpoints".

> What i cannot wrap my mind around is why the command below with
> symmetric difference range gives me non-empty diff
>
> $git diff branch1...branch2

"git diff A...B" is a short-hand for "git diff $(git merge-base A B) B",
naming the fork point between branches A and B as one end, and B as the
other end, of the diff.  Again, diff is about two "endpoints", and the
notation does not mean a symmetric difference range.
