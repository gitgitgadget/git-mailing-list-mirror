From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] http.h: Add debug callback and helper routine for implementing the GIT_TRACE_CURL environment variable in http.c
Date: Tue, 19 Apr 2016 11:00:32 -0700
Message-ID: <xmqqy4891nsv.fsf@gitster.mtv.corp.google.com>
References: <20160419151044.27814-1-gitter.spiros@gmail.com>
	<20160419151044.27814-2-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, tboegi@web.de, ramsay@ramsayjones.plus.com,
	sunshine@sunshineco.com, peff@peff.net
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:00:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asZx3-0002RZ-FW
	for gcvg-git-2@plane.gmane.org; Tue, 19 Apr 2016 20:00:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754042AbcDSSAh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Apr 2016 14:00:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59054 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752924AbcDSSAg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Apr 2016 14:00:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BF58C136FA;
	Tue, 19 Apr 2016 14:00:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3HfsaTdPaAs4
	51SJA2t08I7XtBY=; b=E+HML9clAXLmN4MtJnzAuDInkS3g4uzemS1Kc3cu6eTa
	oQmnmgd6cRKnm0XchmwKAVR86/rc1CkLV046gpsF4AYENsXlz9rJKYMAMu8wYyjv
	6YiQOrsh03eZehx+tcqzEv1XgRhUDAgNUOan2hSj3esE6jjjHPwj0Mgl5J143jo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=j53gtf
	BuOCl8UHt1AssqmEf4TY1L0loyCGGh+GsPRGSUNGXay4SuyPJV2/nP899crQ2MUD
	g3y5BcrCynZ45RWDngE00UU3k85GW65SfFhZxd/yO1Jr6ctrJt8tK3YkdkFQOEcy
	saY219v2sqylH3xs/keHHFVkoIRxdEV5DwEWo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B6FF2136F8;
	Tue, 19 Apr 2016 14:00:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0DCE1136F7;
	Tue, 19 Apr 2016 14:00:34 -0400 (EDT)
In-Reply-To: <20160419151044.27814-2-gitter.spiros@gmail.com> (Elia Pinto's
	message of "Tue, 19 Apr 2016 15:10:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9CF1E216-0658-11E6-BDA0-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291893>

Elia Pinto <gitter.spiros@gmail.com> writes:

> Add the debug callback and helper routine prototype used by
> curl_easy_setopt CURLOPT_DEBUGFUNCTION in http.c
> for implementing the GIT_TRACE_CURL environment variable
>
>
> Helped-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>=20
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  http.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/http.h b/http.h
> index 4ef4bbd..a2d10bc 100644
> --- a/http.h
> +++ b/http.h
> @@ -224,4 +224,10 @@ extern int finish_http_object_request(struct htt=
p_object_request *freq);
>  extern void abort_http_object_request(struct http_object_request *fr=
eq);
>  extern void release_http_object_request(struct http_object_request *=
freq);
> =20
> +/* Debug callback and helper routine for curl_easy_setopt CURLOPT_DE=
BUGFUNCTION */
> +static struct trace_key trace_curl =3D TRACE_KEY_INIT(CURL);

This will be multiply instanciated in every *.c file that includes http=
=2Eh?

> +int curl_trace(CURL *handle, curl_infotype type, char *data, size_t =
size, void *userp);
> +void curl_dump(const char *text, unsigned char *ptr, size_t size, ch=
ar nohex);
> +
> +
>  #endif /* HTTP_H */

In any case, you'd want to combine this with 2/4 and write a single
log message for the combined change.
