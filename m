From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 15:37:11 -0700
Message-ID: <xmqqbnuqoj1k.fsf@gitster.dls.corp.google.com>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
	<1400634170-18266-2-git-send-email-jmmahler@gmail.com>
	<xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
	<20140521215059.GB13956@hudson.localdomain>
	<xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
	<20140521221221.GC13956@hudson.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeremiah Mahler <jmmahler@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:37:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnF8a-0002H2-Kd
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:37:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460AbaEUWhV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:37:21 -0400
Received: from smtp.pobox.com ([208.72.237.35]:63913 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753361AbaEUWhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:37:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4AE5B19C56;
	Wed, 21 May 2014 18:37:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7Hrg5ym+pr5HXhZuVIeLWJU1Nek=; b=e8BSWZ
	7DP1+CafG57QkmT/SwBjz19jOECQS9S4ER7hw6pzAs1zFum3TrCs4v4dKDOduxYz
	ZUTMLmoiDCMN8KAI+JJ1zXZwQguUL6mV4Im5L1rLn65/PBCf0Mmlmoo+WGpW2lzz
	niTDQX0TeslCj24GewJRYgx1U+CDMuE52kZxM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVI8JDGcqG4qKnSUdeaTnZ/dIFyiP+b3
	ieoi2vVIhG2fIrEzWua74nZIjbhNn2pA531STmgKA2o4ZMO9POZvdTiAq8lCA+9W
	IvAMyrbBJ1IHZ4RRra7LW4t4zG6Z4nduQ2uKepbgOUIxZ0WmG6fEHCriy8OlxApb
	Ogl8h/0gK30=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 41C2219C55;
	Wed, 21 May 2014 18:37:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8BBF519C51;
	Wed, 21 May 2014 18:37:12 -0400 (EDT)
In-Reply-To: <20140521221221.GC13956@hudson.localdomain> (Jeremiah Mahler's
	message of "Wed, 21 May 2014 15:12:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 73A47F1E-E138-11E3-B648-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249855>

Jeremiah Mahler <jmmahler@gmail.com> writes:

> Below is one of the updated test cases.
>
> test_expect_success 'format-patch --signature-file=mail-signature' '
> 	cat >mail-signature <<-\EOF
>
> 	Test User <test.email@kernel.org>
> 	http://git.kernel.org/cgit/git/git.git
>
> 	git.kernel.org/?p=git/git.git;a=summary
>
> 	EOF
> 	git format-patch --stdout --signature-file=mail-signature -1 >output &&
> 	check_patch output &&
> 	sed -n -e "/^-- $/,\$p" <output | sed -e "1d" | sed -e "\$d" >output2 &&
> 	test_cmp mail-signature output2
> '

Hmph, there are still few things I do not understand in the above.

 * Why does mail-signature file have a leading blank line?  Is it
   typical users would want to have one there?

 * Similarly, why does mail-signature file need a trailing blank
   line?  Is it usual users would want to have one there?

 * Why three sed in the pipeline?  Wouldn't

    sed -e "1,/^-- \$/d" <output | ...

   be more direct way to start the pipeline without having to strip
   the "-- \n" line with the extra one?

 * Given a mail-signature file that does not end with an incomplete
   line (i.e. we did not have to add the newline to make it
   complete), what are the expected lines in the output after the
   "-- \n" separator?

   Whatever it is, I think it is easier to read the tests if done
   like so:

     sed -e "1,/^-- \$/d" <output >actual &&
     {
         do something to turn mail-signature to what we expect
     } >expect &&
     test_cmp expect actual

   If that "do something" is "to append an extra newline", then it
   would make it a lot clear to do

     {
         cat mail-signature && echo
     } >expect

   than a 'sed -e "\$d"' tucked at the end of the pipeline that only
   tells us we are removing one line that has _something_ without
   explicitly saying what we are removing, no?

Thanks.



   
