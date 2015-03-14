From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/GSoC/RFC] fetch: git fetch --deepen
Date: Sat, 14 Mar 2015 15:07:43 -0700
Message-ID: <xmqqoanvw7v4.fsf@gitster.dls.corp.google.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
	<xmqqlhj0xhsl.fsf@gitster.dls.corp.google.com>
	<CACsJy8C1nHCv0XTDYu+R8QFbG9LqjiUU7kTM1RqnzomtcoVCfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dongcan Jiang <dongcan.jiang@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 23:07:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWuDn-0003gL-Dz
	for gcvg-git-2@plane.gmane.org; Sat, 14 Mar 2015 23:07:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbbCNWHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 18:07:46 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62941 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750849AbbCNWHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Mar 2015 18:07:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B27B3E63B;
	Sat, 14 Mar 2015 18:07:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IIgC0MN3WXZYoVsYof3xex0deGw=; b=J5a9+h
	eZ0O5MFj71w1uwVBRNAug5Pw9EjTU5SGmzAe6IlmWKMFP4CulwCGd5Hlo/OZ2NH1
	lE/Ienaf7l/gXlrm2h45dVyNdMv4TOxSMj+nMyBeQcGiKmsCHe7EOIHPukAq/RKx
	5UCj8wMODotuFl8WVBes5I+7yXH082Ox3FWvE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fbMygioIpemUFO4Vo+0pkbzN+ceJe0e2
	WAhZ4HeDxSAcA3sZeBOjEmBz4gF6+hHqLnhvw0HMFjRIsm3DVoesGANpAMjSxsf7
	akYfx4kllbVHZMXSoJJGbmyMWJQkhQnqKRZ+/ihAErGInBFAbkWOq/shkuKBVhTs
	KHcZHkWJab0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 023C83E63A;
	Sat, 14 Mar 2015 18:07:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7FBBD3E639;
	Sat, 14 Mar 2015 18:07:44 -0400 (EDT)
In-Reply-To: <CACsJy8C1nHCv0XTDYu+R8QFbG9LqjiUU7kTM1RqnzomtcoVCfw@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 14 Mar 2015 17:38:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8A7E3B4C-CA96-11E4-9A11-A2259F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265461>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Mar 14, 2015 at 12:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Dongcan Jiang <dongcan.jiang@gmail.com> writes:
>>> What does (you) exactly mean in [1]? The local branch or the local
>>> remote ref?
>>
>> As this operation is not about moving _any_ refs, whether local
>> branches or remote-tracking branches, any ref that used to point at
>> commit B before you executed "fetch --deepen" would point at the
>> same commit after the command finishes.
>
> That would make it harder to implement "fetch --deepen" than the
> version that moves refs if they are updated.

The comment you are responding to was in the context of "What does
the illustrated 'your' history mean?  Is it a history of a single
ref (if so in which repository)?" to clarify that the example was
not fetching _new_ history (and with the RFC/POC design that was
posted, my understanding is that deepen was meant to only deepen).

The paragraph you are reacting to is not an endorsement for that
"only deepen, never advance" design. It merely is a clarification of
the explanation that was in the paragraph that follows.

> And I think what Dongcan
> implemented moves refs. From the user point of view, I think it's ok
> with either version, so the one that's easier to implement wins.
>
>> The "you" does not explicitly depict any ref, because the picture is
>> meant to illustrate _everything_ the repository at the receiving end
>> of "fetch" has.  It used to have two commits, A and B (and the tree
>> and blob objects necessary to complete these two commits).  After
>> deepening the history by one commit, it then will have commit A^ and
>> its trees and blobs.
>>
>>> [1] http://article.gmane.org/gmane.comp.version-control.git/212950
