From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/10] cat-file: use streaming interface to print
 blobs
Date: Sun, 04 Mar 2012 15:12:13 -0800
Message-ID: <7vling6jw2.fsf@alter.siamese.dyndns.org>
References: <1330329315-11407-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-1-git-send-email-pclouds@gmail.com>
 <1330865996-2069-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 05 00:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4KbH-0008Hc-W1
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 00:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755989Ab2CDXMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Mar 2012 18:12:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39740 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755708Ab2CDXMQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Mar 2012 18:12:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA10E612F;
	Sun,  4 Mar 2012 18:12:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ezrOUsZdV1hp
	foCAo2mZl5PZMBw=; b=C6SVFsEkqWfxlLWrcY1s+yFhi65V00F6OQmPD37k/UR8
	IfpKbIa2/7FqMMB9REEQju6FyOfwXHJ3gM9gMzW30I4j4OSpwAtEA+aZpjit3dAl
	SmyHZvxa8ZCwOhCsiwU2MkQiA2x6weQDRsJtBV7EcztuG/O4JUhN1m1goGJrnA4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AejYSt
	CFOcyXSzx6TOmcnOuZh4MP7qPu8wVdPXYOt+DR2btiWd1Vbw1po7TPWOCE7GkPUV
	4ke9WdcRRGcmVbWEEwAd7qBOS3N49voIUYcMJM3gskQVZxUMeIhye0umvw8cZRJj
	7ZQDH47zoizsFctl1eXygfxyE8ujGPdx9L8+w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D129D6129;
	Sun,  4 Mar 2012 18:12:15 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5AC056122; Sun,  4 Mar 2012
 18:12:15 -0500 (EST)
In-Reply-To: <1330865996-2069-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 4 Mar
 2012 19:59:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7B3C6888-664F-11E1-927C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192180>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +static int write_blob(const unsigned char *sha1)
> +{
> +	unsigned char new_sha1[20];
> +
> +	if (sha1_object_info(sha1, NULL) =3D=3D OBJ_TAG) {

Hrm, didn't I say that it tastes bad for a function write_blob() to hav=
e
to worry about OBJ_TAG already?
