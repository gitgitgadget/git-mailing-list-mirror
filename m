From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Fix some warnings (on cygwin) to allow -Werror
Date: Fri, 04 Jul 2008 01:59:02 -0700
Message-ID: <7vskuquisp.fsf@gitster.siamese.dyndns.org>
References: <486CF5A9.5060104@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 04 11:00:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEh9E-0001sP-VD
	for gcvg-git-2@gmane.org; Fri, 04 Jul 2008 11:00:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793AbYGDI7L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 04:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753314AbYGDI7L
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 04:59:11 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38293 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbYGDI7J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 04:59:09 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 28E5C14BD9;
	Fri,  4 Jul 2008 04:59:08 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7B0E814BD7; Fri,  4 Jul 2008 04:59:04 -0400 (EDT)
In-Reply-To: <486CF5A9.5060104@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Thu, 03 Jul 2008 16:52:09 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7625E072-49A7-11DD-B4DF-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87374>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> Despite the subject line, this should be useful on any system for
> which uint32_t is defined to be unsigned long rather than
> unsigned int. (and where the return type of htonl() is similarly
> defined).

Correct.  Perhaps "Use %PRIu32 and such to print integers of fixed length"?

The only worry I have with this patch is with systems with not-so-ANSI
headers; as you noticed, we already have:

        #ifndef PRIuMAX
        #define PRIuMAX "llu"
        #endif

in git-compat-util.h, which does include <inttypes.h>, so PRIu32 and
friends could be problematic on these platforms.

> @@ -1718,7 +1720,8 @@ static int add_ref_tag(const char *path, const unsigned char *sha1, int flag, vo
>  static void prepare_pack(int window, int depth)
>  {
>  	struct object_entry **delta_list;
> -	uint32_t i, n, nr_deltas;
> +	uint32_t i, nr_deltas;
> +	unsigned n;

Hmm.  Is this change necessary?
