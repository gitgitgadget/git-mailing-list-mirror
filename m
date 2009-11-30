From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] git-merge-recursive-{ours,theirs}
Date: Sun, 29 Nov 2009 22:21:50 -0800
Message-ID: <7vvdgs1qip.fsf@alter.siamese.dyndns.org>
References: <d243a513ffb8da4272f7a0e13a711f9b65195c25.1259201377.git.apenwarr@gmail.com>
 <905749faf5ccb2c7c54d3318dbc662d69daf8d0e.1259201377.git.apenwarr@gmail.com>
 <cover.1259201377.git.apenwarr@gmail.com>
 <7e1f1179fc5fe2f568e2c75f75366fa40d7bbbfb.1259201377.git.apenwarr@gmail.com>
 <7vr5rlerqf.fsf@alter.siamese.dyndns.org>
 <32541b130911261405q6564d8f2o30b7d7fd6f708d05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 30 07:22:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEzeE-0001Le-2r
	for gcvg-git-2@lo.gmane.org; Mon, 30 Nov 2009 07:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753474AbZK3GVy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Nov 2009 01:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753462AbZK3GVx
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Nov 2009 01:21:53 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41703 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbZK3GVw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Nov 2009 01:21:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3323EA2198;
	Mon, 30 Nov 2009 01:21:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=tATt++3y65NvPxkLkmWCAzhgJ
	Kw=; b=QqLQBSSNDvPRLTjD7Cw/56jleLST08BtL2XniczenOjM5M904NZWDje9n
	Hd0DArQF/VKjpmQBn2Oeh+Cjvpcv5CM3BCWZuZYRUsosl5RXRFK+DkfssATQCLA/
	tH6MZaqpGn+AYPXzvgRdc43OPEsY98xtGMVtJUoYIkiDwK+XPY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=SG8tBauTVOdz4SslLsj
	/BgI679iyxI/Porz97O5NIYwOriQBHfYPFtcQn8krMA03zv+4+Hdw61+RQNOOfi/
	Y3Nc6IqKPDtZhcYCKFvAJP6Wyw3Z0fyXGPUfa87x1EUmqjhmpr447yra6hts57AD
	b1RFPmElPR+BRBFFvrgA92Ko=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 10D22A2193;
	Mon, 30 Nov 2009 01:21:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E0F37A218A; Mon, 30 Nov 2009
 01:21:51 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A7E42AAE-DD78-11DE-B761-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134054>

Avery Pennarun <apenwarr@gmail.com> writes:

>> =C2=A0- I think we should avoid adding the extra argument to ll_merg=
e_fn() by
>> =C2=A0 combining virtual_ancestor and favor into one "flags" paramet=
er. =C2=A0If
>> =C2=A0 you do so, we do not have to change the callsites again next =
time we
>> =C2=A0 need to add new optional features that needs only a few bits.
>>
>> =C2=A0 I vaguely recall that I did the counterpart of this patch tha=
t way
>> =C2=A0 exactly for the above reason, but it is more than a year ago,=
 so maybe
>> =C2=A0 I didn't do it that way.
>
> You did do that, in fact,... <<rationale omitted>>

Think of the "flag" parameter as a mini "struct option".  When you add =
a
feature to a function at or near the leaf level of call chains that are
potentially deep, you add one element to the option structure, and take
advantage of the fact that existing callers put a sane default value in
the new field, i.e. 0, by doing a "memset(&opt, 0, sizeof(opt))" alread=
y,
so that the callsites that do not even have to know about the new featu=
re
will keep working the same old way without breakage.  You saw this exac=
t
pattern in the [1/8] patch in your series to cram new "favor this side"
information into an existing parameter.

As you mentioned, sometimes changing function signature is preferred to
catch semantic differences at compilation time.  The report given by th=
e
compiler of extra or missing parameter at the call site is a wonderful =
way
to find out that you forgot to convert them to the new semantics of the
function.  This also helps when there is an in-flight patch that adds a
new callsite to the function whose semantics you are changing.  The
semantic conflict is caught when compiling the result of a merge with a
branch with such a patch.  It is a trick worth knowing about.

The approach however cuts both ways.  When you are adding an optional
feature that is used only in a very few call sites, the semantic merge
conflict resulting from such a function signature change is rarely wort=
h
it.

As long as you choose the default "no-op" value carefully enough so tha=
t
existing callers will naturally use it without modification, the old co=
de
will work the way they did before the new optional feature was added.  =
In
other words, "let's implement this as purely an opt-in feature" is ofte=
n
preferrable over "let's force semantic conflict and compilation failure=
,
just in case existing callsites may also want to trigger this new
feature".

That is why [1/8] patch in your series uses 0 to mean "don't do the fun=
ny
'favor' trick, but just leave the conflicts there".

I've queued the series with minor fixes to 'pu' and pushed it out.
