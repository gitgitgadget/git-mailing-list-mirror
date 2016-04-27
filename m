From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/83] builtin/apply: avoid parameter shadowing 'linenr' global
Date: Wed, 27 Apr 2016 09:27:39 -0700
Message-ID: <xmqqtwin9fus.fsf@gitster.mtv.corp.google.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-4-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 18:31:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avSN3-0002VX-Nm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbcD0QbU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:31:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55009 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752291AbcD0Q1m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:27:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6762C15A57;
	Wed, 27 Apr 2016 12:27:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YUFpOMDGGVCicUzHM9n0+VWorqI=; b=Ghzb9F
	9QuMzAq5ySkNqG01SrMKoouOYm6Ija61/kWHhPsN+PWkleRmTF8J5qz3Sav2xTqB
	ywK4rhdK4MtxtinqxB3jkVvX68a9IYjFuGBNllAMzAyfbx7RnbehfXIXy9lg/QF+
	RYJQ9FErV6idPe2LkJ8Ji0lNeHkfcEh/vJ2dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pYg6kTp47VX2wO8EgFAx6A2r8j5tzyU3
	j5sJ/vV7idGkpo/mgR1xalbc07lV51loB8YsHrvvpKsvAcpYsH8N/e1IK5/LJmtt
	wvHaByKjMmu3JNlszO3Xl8bFuy7alSLrcxXOYISRScb6pP7kJpetC8TghChMYOeL
	ugBCabm1HQM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5FA5415A56;
	Wed, 27 Apr 2016 12:27:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F85015A55;
	Wed, 27 Apr 2016 12:27:40 -0400 (EDT)
In-Reply-To: <1461504863-15946-4-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Sun, 24 Apr 2016 15:33:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F634AB82-0C94-11E6-9FA2-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292743>

Christian Couder <christian.couder@gmail.com> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---

I think 02/83 that renamed the global-to-be-moved-to-state to
state_p_value was brilliant, and this should follow suit; you would
be moving linenr into the state eventually in later steps, right?

>  builtin/apply.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index e133b38..7115dc2 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -1516,7 +1516,7 @@ static int find_header(const char *line, unsigned long size, int *hdrsize, struc
>  	return -1;
>  }
>  
> -static void record_ws_error(unsigned result, const char *line, int len, int linenr)
> +static void record_ws_error(unsigned result, const char *line, int len, int l_nr)
>  {
>  	char *err;
>  
> @@ -1530,7 +1530,7 @@ static void record_ws_error(unsigned result, const char *line, int len, int line
>  
>  	err = whitespace_error_string(result);
>  	fprintf(stderr, "%s:%d: %s.\n%.*s\n",
> -		patch_input_file, linenr, err, len, line);
> +		patch_input_file, l_nr, err, len, line);
>  	free(err);
>  }
