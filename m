From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] index-pack: eliminate recursion in
 find_unresolved_deltas
Date: Thu, 12 Jan 2012 12:32:43 -0800
Message-ID: <7vipkg1x1w.fsf@alter.siamese.dyndns.org>
References: <1324901080-23215-1-git-send-email-pclouds@gmail.com>
 <1326081546-29320-3-git-send-email-pclouds@gmail.com>
 <7vzkdwcys4.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cz-qWs2wrOYTjDMPjJH0wRQCFy9u6OFVPzn6YV0a6WaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 12 21:32:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlRKN-0005TL-LF
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 21:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755240Ab2ALUcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jan 2012 15:32:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57671 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755126Ab2ALUcq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jan 2012 15:32:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A9B45514;
	Thu, 12 Jan 2012 15:32:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RGMDV5TQAxKD
	J3QqO+SIDGAQQJc=; b=C8UfZIk5sNRy+lHvEsRntK912IA833YwSx+gnVqSwmtl
	TibVimI7OpMPZpkZvxoxQsvOlQdALSLvUoIN1dvrHoWByA3ffclpHSlncPyL18TH
	2k3LYLAj4J8AiK60+1pE/NEWwX7Wl/fDx/gPrBmyRYSfWrsBkf2BMz3oAXoi4lI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=aCJSiF
	S/GOaN0B6032a0PWRorCNfhTlcHVxateLutUGJqW84sAYTWxOS3lJky7GH3+ILL1
	hluYltTyZsY/Dnb5NXWrmMW5L15B6IWMRramCgB6yYuuL1VH61ipYaMhAa8o29o7
	G+oeTdrQa7NzexlN0fSE8lSdAb4JeUpK/zBPo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 817EF5513;
	Thu, 12 Jan 2012 15:32:45 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 094275512; Thu, 12 Jan 2012
 15:32:44 -0500 (EST)
In-Reply-To: <CACsJy8Cz-qWs2wrOYTjDMPjJH0wRQCFy9u6OFVPzn6YV0a6WaQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Tue, 10 Jan 2012 19:23:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95645746-3D5C-11E1-9094-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188482>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> 2012/1/10 Junio C Hamano <gitster@pobox.com>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> =
writes:
>>
>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@g=
mail.com>
>>
>> I find both the original and the updated code rather dense to read w=
ithout
>> annotation, but from a cursory look all changes look good.
>
> Maybe I stared at it for too long it seems obvious to me (hence no
> further description in commit message). Let me describe it (and put i=
n
> commit message later if it makes sense)
>
> Current code already links all bases together in a form of tree, usin=
g
> struct base_data, with prev_base pointer to point to parent node. The
> only problem is that struct base_data is all allocated on stack. So w=
e
> need to put all on heap (parse_pack_objects and
> fix_unresolved_deltas). After that, it's simple depth-first traversal
> where each node also maintains its own state (ofs and ref indices to
> iterate over all children nodes).
>
> So we process one node:
>
>  - if it returns a new (child) node (a parent base), we link it to ou=
r
> tree, then process the new node.
>  - if it returns nothing, the node is done, free it. We go back to
> parent node and resume whatever it's doing.
>
> and do it until we have no nodes to process.

If you have the current path (base to another that is recorded as a del=
ta
to it to yet another that is recorded as a delta to that delitified
object) on the stack, it is obvious that as you have done with the obje=
cts
on the deeper end of the delta chain, the data that becomes unnecessary
will be gone by simply returning from the recursion, but if you "put al=
l
on heap", you would have to do the same freeing as part of the hand-rol=
led
recursion. It is unclear if, where and how the patch takes care of that
in the above.

Other than that, I find the description very readable.

Thanks.
