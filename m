From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/8] Rename struct diff_filespec's sha1_valid member.
Date: Tue, 07 Jun 2016 12:14:42 -0700
Message-ID: <xmqqmvmwq09p.fsf@gitster.mtv.corp.google.com>
References: <20160607005716.69222-2-sandals@crustytoothpaste.net>
	<20160607005716.69222-5-sandals@crustytoothpaste.net>
	<575667E6.7030509@kdbg.org>
	<20160607062324.GA29484@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Johannes Sixt <j6t@kdbg.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 21:17:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAMSg-0002EI-8m
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 21:14:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbcFGTOq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 15:14:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751228AbcFGTOp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 15:14:45 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C963233D7;
	Tue,  7 Jun 2016 15:14:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cplSMLORAkcXEc/804fjh2uKMBQ=; b=GC0wjo
	PuJC/IqgYJH+GVIKx2vsErMDViRNjY+bJiiWD4P/+a5Nr2DAODBh4GvzGTEdBE83
	EguytrDoWoBagkJGlnfQHWLn89GaZtBix8+g8VtP/cvLsFANPS6DOnl+A5vSAVNR
	d4Q6ECDpbL/wRMZR0s/XqMRGvDAHrJEJfTuVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sqfv9mKCKKhSncfsfU9nj4D7wrQ9pOcT
	G4Nmz94Vp29/7g3yV9F1y5+To/WXXlElF7H2tbi7hSI0ugZgSD8fWLZNmnGoq4YK
	qTeG7D3VDHQQwN6lFg0G7BTsXSEYgsxSy4loRPchudNcUA41Z8pXjJ2CjZCBRHcQ
	Zzpf4U6n23k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75356233D6;
	Tue,  7 Jun 2016 15:14:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4FD2233D5;
	Tue,  7 Jun 2016 15:14:43 -0400 (EDT)
In-Reply-To: <20160607062324.GA29484@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jun 2016 02:23:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 17854FDE-2CE4-11E6-8B04-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296709>

Jeff King <peff@peff.net> writes:

> On Tue, Jun 07, 2016 at 08:21:26AM +0200, Johannes Sixt wrote:
>
>> > diff --git a/combine-diff.c b/combine-diff.c
>> > index f39be434..a20caa80 100644
>> > --- a/combine-diff.c
>> > +++ b/combine-diff.c
>> > @@ -1269,7 +1269,7 @@ static struct diff_filepair *combined_pair(struct combine_diff_path *p,
>> >   		pair->one[i].path = p->path;
>> >   		pair->one[i].mode = p->parent[i].mode;
>> >   		oidcpy(&pair->one->oid, &p->parent[i].oid);
>> > -		pair->one[i].sha1_valid = !is_null_oid(&p->parent[i].oid);
>> > +		pair->one->oid_valid = !is_null_oid(&p->parent[i].oid);
>> 
>> Is this transformation correct?
>
> Or the oidcpy() above it, which was introduced in patch 3.

Indeed these look wrong.
