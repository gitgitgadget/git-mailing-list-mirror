From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] graph: avoid infinite loop in graph_show_commit()
Date: Mon, 24 Sep 2012 16:36:31 -0700
Message-ID: <7vtxunvvr4.fsf@alter.siamese.dyndns.org>
References: <1348323880-3751-1-git-send-email-pclouds@gmail.com>
 <loom.20120923T135253-178@post.gmane.org>
 <CACsJy8ApYKOU8v_-HkUC5uOb8gsheugKaXKMjbm0_-ygW_4jiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michal Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org, adam@adamsimpkins.net
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 01:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGICi-0004Ft-Ho
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 01:36:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889Ab2IXXgf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 19:36:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778Ab2IXXge convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 19:36:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D60209590;
	Mon, 24 Sep 2012 19:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Xo0Y0bPE7b+F
	kO6a3itJOb8TXEI=; b=LYKWgFlpjRkPaMITT+R1V4ovIvRftamSzbdb+w8c35dS
	jqDsltOZ6Y192Bf56x3Z179wUQgH/YY/lfUrLRbplgNA8s7ohasofSwoONpgAmox
	UazF9ajuVKLbR+/dALkoBGIE99+yjYneVtph6z83toqsHcNNV6s4Vse+Q9Xgyro=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MroZR4
	hJ8jCAF40+kqA8Vs2AcgzDDJtxgPlJl1sPKCnZLCTjFbX8S3yH1JqucmRATkN6oy
	VOPMHbZ87QNCjBNHTZoBnqGqZ1wAIdzycOgbINLSY/1ihTVhhYhCsagMaW/RR/5J
	PurAZC5gylwfCrgtXRoFhd+qHIH1CwhNWSsIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C328C958F;
	Mon, 24 Sep 2012 19:36:33 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C467958E; Mon, 24 Sep 2012
 19:36:33 -0400 (EDT)
In-Reply-To: <CACsJy8ApYKOU8v_-HkUC5uOb8gsheugKaXKMjbm0_-ygW_4jiQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sun, 23 Sep 2012 19:14:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC6D133E-06A0-11E2-823D-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206334>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Sun, Sep 23, 2012 at 6:55 PM, Michal Kiedrowicz
> <michal.kiedrowicz@gmail.com> wrote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds <at> gmail.com> w=
rites:
>>
>>>
>>> The loop can be triggered with "git diff-tree --graph commit" where
>>> the commit is a non-merge. It goes like this
>>
>>
>> Isn't this the same issue as in
>> http://article.gmane.org/gmane.comp.version-control.git/123979
>> ? (with slightly different fix)
>
> I don't know. I'm not familiar enough with graph.c to tell. Maybe Ada=
m
> can have a look?

Has either of you tried the patch with the problematic case the
other patch tries to solve?  Michal's old patch does smell like it
is going in the better direction in that it stops looping when we
know we would only be showing the padding, which is a sign that we
are done with showing the commit.

But I didn't look at it too closely.  I'd prefer to see the
assert(0) turned into die("BUG: internal error") at the end of
graph_next_line() to catch these cases.  Also I am not sure if
assignment of the return value from graph_next_line() to
shown_comit_line in the loop is correct (shouldn't it be OR'ing it
in, so that "we have shown the information on this commit" is not
lost when the function adds things after showing the commit???)
