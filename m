From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] sha1_file: make sure correct error is propagated
Date: Fri, 14 Nov 2008 11:05:19 -0800
Message-ID: <7vfxlu9lhs.fsf@gitster.siamese.dyndns.org>
References: <1226647174-15844-1-git-send-email-sam@vilain.net>
 <200811140844.58746.fge@one2team.com> <1226655681.17731.4.camel@maia.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Nov 14 20:07:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L141B-0006Cc-0K
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 20:07:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755858AbYKNTGb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 14:06:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754193AbYKNTGb
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 14:06:31 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59305 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753936AbYKNTGa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 14:06:30 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id ECB6D16AE8;
	Fri, 14 Nov 2008 14:06:24 -0500 (EST)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 1900D16AE5; Fri, 14 Nov 2008 14:05:20 -0500 (EST)
In-Reply-To: <1226655681.17731.4.camel@maia.lan> (Sam Vilain's message of
 "Fri, 14 Nov 2008 22:41:21 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 551D7610-B27F-11DD-AEB7-C128113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101002>

Sam Vilain <sam@vilain.net> writes:

> Subject: sha1_file: accept EACCESS as equivalent to EPERM
>
> This was testing for 'Operation not permitted' rather than any kind
> of 'Permission Denied' error; prefer EACCESS.
>     
> Signed-off-by: Sam Vilain <sam@vilain.net>
> --
>   Sorry for the inevitable wrapping/whitespace fail :(
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 7662330..cd422e6 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2231,7 +2231,7 @@ static int create_tmpfile(char *buffer, size_t
> bufsiz, const char *filename)
>  	memcpy(buffer, filename, dirlen);
>  	strcpy(buffer + dirlen, "tmp_obj_XXXXXX");
>  	fd = mkstemp(buffer);
> -	if (fd < 0 && dirlen && (errno != EPERM)) {
> +	if (fd < 0 && dirlen && (errno != EACCESS)) {

Is this accepting the two as equivalents???
