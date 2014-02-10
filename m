From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] gc: config option for running --auto in background
Date: Mon, 10 Feb 2014 10:43:43 -0800
Message-ID: <xmqqob2est9c.fsf@gitster.dls.corp.google.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com>
	<1391843332-20583-1-git-send-email-pclouds@gmail.com>
	<1391843332-20583-2-git-send-email-pclouds@gmail.com>
	<CABPQNSb3=i8F+vPEG3RmH+snZVZ-xrPtcVY2Nx9uvyTCLXcy6g@mail.gmail.com>
	<CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Faye-Lund <kusmabite@gmail.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	chris <jugg@hotmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 10 19:43:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCvph-0000wI-Vx
	for gcvg-git-2@plane.gmane.org; Mon, 10 Feb 2014 19:43:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbaBJSnt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Feb 2014 13:43:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62296 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752608AbaBJSns (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Feb 2014 13:43:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C93B96A825;
	Mon, 10 Feb 2014 13:43:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yn/nODhNihoVjFDGUNNMrOsX6Wc=; b=VMZGVH
	sRM3AJR8rCK12kGa7wuT4TzAR84anWJDqgxAr4J11cYdVP53xJpNApCL4G4DXJLk
	pvBvbMSZ6pRSv8APHUEwU1eJPd5DScc443Qlp6jPPL17lFrOqCsBP0LrejYzYhJk
	RUpHCUirMeHrvlm5lH9hkCW2uTp98mT1OR1Kg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vgsCT4e9Y3rgHqZ6qkuqFq8kYugLvmz4
	xd76WyXgU5XUzsvC1DS+TpaTZZcWR4sUKsl/DsEXSvk6vFWHfM8N/8lQkxCztIV5
	cTjbXoHxrQKE9bG9kY6dNivkQJQ0voQeslQEvQq6Ki/8E1U9RFs2yKSoWfjyuMdq
	R+V4vAmzju0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CBC526A81E;
	Mon, 10 Feb 2014 13:43:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 246926A810;
	Mon, 10 Feb 2014 13:43:45 -0500 (EST)
In-Reply-To: <CACsJy8BBQ3Bh6q6JM8V-QVKfzwp1w99+u4_55jjGbHLV3c62gA@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 10 Feb 2014 20:17:28 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 454415AC-9283-11E3-B8D7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241921>

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Feb 10, 2014 at 6:03 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> `gc --auto` takes time and can block the user temporarily (but not any
>>> -               if (!quiet)
>>> -                       fprintf(stderr,
>>> -                                       _("Auto packing the repository for optimum performance. You may also\n"
>>> -                                       "run \"git gc\" manually. See "
>>> -                                       "\"git help gc\" for more information.\n"));
>>> +               if (!quiet) {
>>> +                       if (detach_auto)
>>> +                               fprintf(stderr, _("Auto packing the repository in background for optimum performance.\n"));
>>> +                       else
>>> +                               fprintf(stderr, _("Auto packing the repository for optimum performance.\n"));
>>> +                       fprintf(stderr, _("See \"git help gc\" for manual housekeeping.\n"));
>>> +               }
>>> +               if (detach_auto)
>>> +                       /*
>>> +                        * failure to daemonize is ok, we'll continue
>>> +                        * in foreground
>>> +                        */
>>> +                       daemonize();
>>
>> While I agree that it should be OK, shouldn't we warn the user?
>
> If --quiet is set, we should not be printing anyway. If not, I thinkg
> we could only print "auto packing in background.." when we actually
> can do that, else just print the old message. It means an #ifdef
> NO_POSIX_GOODIES here again though..

Didn't you change it not to die but return nosys or something?
