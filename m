From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Mon, 26 Nov 2012 14:22:12 -0800
Message-ID: <7vsj7wovhn.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
 <7vd2z7rj3y.fsf@alter.siamese.dyndns.org> <20121121041735.GE4634@elie.Belkin>
 <7vfw43pmp7.fsf@alter.siamese.dyndns.org>
 <20121121194810.GE16280@sigill.intra.peff.net>
 <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
 <7v7gp9udsl.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1211261726260.7256@s15462909.onlinehome-server.info>
 <7vd2z0tfhz.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1211262024520.7256@s15462909.onlinehome-server.info>
 <CAGdFq_iLYHs_tUDRsT9X1J12vSp3TUoMJQVbjw4ZgxONL6tMCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Max Horn <max@quendi.de>, Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 23:22:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Td74R-0005z3-8D
	for gcvg-git-2@plane.gmane.org; Mon, 26 Nov 2012 23:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089Ab2KZWWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2012 17:22:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab2KZWWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Nov 2012 17:22:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 50408A8B0;
	Mon, 26 Nov 2012 17:22:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uD2JKK1qsg6YmiYTyF1NPJs+KlE=; b=RlwyaH
	+WpcwAiY9OU/TMvWzxmpe/k8BTjbB+/LUsCXWcpqxKtedWn2/WCFHBofyaFEHgTm
	lyPGjt6OK8zkQ+JfiC9g+zO6UQh1wHgAE/M0PeNoEY9oJP1zNEX3yJWv2yC7s3mL
	un5eMYZRlvyKcenNPEmL25HPpJTkY4ZH2KgrQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=C2p6jDePF3ckZrbs/t5xrs6RtBY0LUK3
	OdmQ1lS1E/vEWEKoQKPPkTv9KCKYdUqxz17NPxvnnwwvWP1g7LZeQtwHcOLbZWVt
	Aw1QNIUuPdqFlBovx8O+PQoADE+uNSLkZaRJ+YA2do+43hkN+NEMu7gU5yvAeENS
	iTQzRpUTlZs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 327F7A8AE;
	Mon, 26 Nov 2012 17:22:14 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7EBCFA8A8; Mon, 26 Nov 2012
 17:22:13 -0500 (EST)
In-Reply-To: <CAGdFq_iLYHs_tUDRsT9X1J12vSp3TUoMJQVbjw4ZgxONL6tMCA@mail.gmail.com> (Sverre
 Rabbelier's message of "Mon, 26 Nov 2012 13:46:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA4CF264-3817-11E2-9036-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210506>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Nov 26, 2012 at 11:26 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>>> We added rev_cmdline_info since then so that we can tell what refs
>>> were given from the command line in what way, and I thought that we
>>> applied a patch from Sverre that uses it instead of the object
>>> flags.  Am I misremembering things?
>>
>> It does sound so familiar that I am intended to claim that you remember
>> things correctly.
>
> FWIW, I implemented that in
> http://thread.gmane.org/gmane.comp.version-control.git/184874 but
> didn't do the work to get it merged.

Ah, OK.  Should I expect an updated series then?  How would it
interact with the recent work by Felipe?
