From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 4/6] send-email: create email parser subroutine
Date: Wed, 08 Jun 2016 12:31:11 -0700
Message-ID: <xmqqbn3blbpc.fsf@gitster.mtv.corp.google.com>
References: <20160607140148.23242-1-tom.russello@grenoble-inp.org>
	<20160608130142.29879-1-samuel.groot@grenoble-inp.org>
	<20160608130142.29879-5-samuel.groot@grenoble-inp.org>
	<xmqq8tyfmuk4.fsf@gitster.mtv.corp.google.com>
	<CAPig+cTO+-aATxyNBt2HtctH_ofgqEc8ik3OLSN+THVgu6dhKQ@mail.gmail.com>
	<xmqqr3c7lefw.fsf@gitster.mtv.corp.google.com>
	<116d56ee-afdf-b1f2-f141-7449e6503f30@grenoble-inp.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, tom.russello@grenoble-inp.org,
	erwan.mathoniere@grenoble-inp.org, jordan.de-gea@grenoble-inp.org,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>, aaron@schrab.com,
	Eric Wong <e@80x24.org>
To: Samuel GROOT <samuel.groot@grenoble-inp.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:31:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAjCJ-0002YT-Cw
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:31:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423757AbcFHTbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:31:18 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59719 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423729AbcFHTbO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:31:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7408D21225;
	Wed,  8 Jun 2016 15:31:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dx9o/aV8lCnmQlo2FK2pegWwTno=; b=gV1I8p
	XhQAz1hKWGiImCMh80DyHkG2nTF1u4BGcLL8C2K04LNG0RTcLyrdYZa+FRdziSPi
	shgA3vISEGBL6KJIJa0nVSdCRUo4hr9ytpHB9/li6ikMSCEtq9jOOFjozV9imOkC
	gPKbsmwZQAE5/7XDLOqO2MY7SzLEtr1jJoQUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QzJoSrLlt7ptiJ5XK5OMfkdecIeIUZai
	yQSWKAgeKCJ2M2koV1108wljZw7wc93A3GPrV8iDYI7lGXILDPHXZcufCze427/Y
	R6KO+JXsQx5H/LTI3wI2b0A12dZrJCawPn/AU40PkT2kZhVpqrpy0Hu2kuJd2e7W
	6hkwMa/21EQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 69C1A21224;
	Wed,  8 Jun 2016 15:31:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E086721222;
	Wed,  8 Jun 2016 15:31:12 -0400 (EDT)
In-Reply-To: <116d56ee-afdf-b1f2-f141-7449e6503f30@grenoble-inp.org> (Samuel
	GROOT's message of "Wed, 8 Jun 2016 21:26:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 8F69E9B2-2DAF-11E6-8946-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296841>

Samuel GROOT <samuel.groot@grenoble-inp.org> writes:

> I think it's the best way to do it indeed. Furthermore, we did trim
> CRs and LFs in header fields, but not in the message, making the
> subroutine inconsistent.
>
> Should we rename the subroutine to `parse_header` or leave it as it is?

If it lives inside git-send-email, then parse_header is sufficient
as everybody would know it is about e-mail without being told.  If
it is in Git.pm, then parse_email_header would be more appropriate.
