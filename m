From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] commit, write-tree: allow to ignore CE_INTENT_TO_ADD
 while writing trees
Date: Mon, 16 Jan 2012 15:21:46 -0800
Message-ID: <7vaa5nutbp.fsf@alter.siamese.dyndns.org>
References: <1326681407-6344-1-git-send-email-pclouds@gmail.com>
 <1326681407-6344-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 17 00:21:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmvsB-0002cO-N5
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 00:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab2APXVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Jan 2012 18:21:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54180 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750830Ab2APXVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Jan 2012 18:21:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1004151D1;
	Mon, 16 Jan 2012 18:21:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=PJA8je80SXkz
	6coFia2uqma+rlg=; b=Bv6Ov6sNgt4SMuhyDxeFqkr83iNT77FMzJi6besaf21x
	ubZeW7IZzu6CdLUyudhDrVsl/W4sT5Wfz3VKyUZQXVRmAFscW3/ZFyTX97CV7OGq
	ayoiw4++3Ipbh0iPmUrMJkG4o2xsfZMU/Ih4338jpGOBR30Plpq+duWggUn77YM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e/g7EI
	2evmJK5MY2DECacrpqQDq4ecGmRc0MGoC5JdPegUG86DIWvpPyMoQTpdfYtbsVtD
	yMd8CBRh/BWq4pqoyGcFZdpPV6mYBYaKtrsekbXXm00INTPaso/O9f2Q9guFtVYX
	KKcc/3nBZWvLdshGqBV+g+NCZDIfDVtQV17Tg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08C3151D0;
	Mon, 16 Jan 2012 18:21:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 634F551CF; Mon, 16 Jan 2012
 18:21:48 -0500 (EST)
In-Reply-To: <1326681407-6344-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Mon, 16 Jan
 2012 09:36:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DCF683C4-4098-11E1-A63E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188673>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> Normally cache-tree will not produce trees from an index that has
> CE_INTENT_TO_ADD entries. This is a safe measure to avoid
> mis-interpreting user's intention regarding this flag.

s/safe/safety/;

> There are situations however where users want to create trees/commits
> regardless i-t-a entries.

A new command line option "--no-check-intent-to-add" to "commit" withou=
t
any configuration bit may be a useful addition as a first cut, and in
order to help users to which "there are situations" is more than 50% of
the time, a configuration that can be overriden by "--check-intent-to-a=
dd"
may be a usability improvement over that first cut, but if this is real=
ly
about "there are situations", then a configuration that cannot be
overriden by command line option feels a wrong way to go about it.

Is this really about "there are situations" to begin with? I am suspect=
ing
that this patch is either:

 (1) making it easier to use a wrong workflow, by promoting a way to
     bypass a useful safety measure;

 (2) fixing an earlier UI mistake (iow, the interpretation #2 in the ol=
d
     discussion is always the right one and the existing safety measure=
 is
     misguided) in such a way that allows you to work around an objecti=
on
     from a bonehead maintainer who refuses to admit that earlier mista=
ke;
     and/or

 (3) splitting the Git userbase into two and making the resulting syste=
m
     harder to teach.

If it is (2), and I suspect it may be the case, we might want to rather
honestly describe that the future direction is to fix it, and describe =
the
configuration option as "an early opt-in" switch, together with the usu=
al
three-step deprecation and migration schedule to make the new behaviour
the default in a future version. From the timeline point of view, it
probably can coincide with the change to always start an editor when
recording a merge commit.

In any case, for this change to help people who add more than one paths
with "add -N" and want to include only a subset of them in the commit, =
we
may want to explicitly teach them to add what they want to before
committing with the new command line option in the documentation.
