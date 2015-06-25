From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 5/5] bisect: allow any terms set by user
Date: Thu, 25 Jun 2015 15:10:24 -0700
Message-ID: <xmqqfv5fwib3.fsf@gitster.dls.corp.google.com>
References: <1435064084-5554-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-1-git-send-email-Matthieu.Moy@imag.fr>
	<1435258257-29047-6-git-send-email-Matthieu.Moy@imag.fr>
	<xmqqk2urwjmq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, antoine.delaite@ensimag.grenoble-inp.fr,
	louis--alexandre.stuber@ensimag.grenoble-inp.fr,
	chriscool@tuxfamily.org, thomasxnguy@gmail.com,
	valentinduperray@gmail.com,
	Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 26 00:10:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8FLr-0001sm-SH
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 00:10:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbbFYWK1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Jun 2015 18:10:27 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:36739 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241AbbFYWK0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jun 2015 18:10:26 -0400
Received: by igbiq7 with SMTP id iq7so1799244igb.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2015 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=q58KMxiWe5AQzRhIFSR3J2wqoKxxinwsrc3rhGgeNLg=;
        b=Qrobv9P/2va/t+YX/Y6TucyauWhHxjB3MNBOqkVPPoVdajCNQ4WVz3E2ZAvlwiKJ+S
         8uj0dqXkRQ+VBeC2F8o/X6eYko9WAg088eobIs7FxTYkKWAXMIpG1un+5bAkKXXcIICu
         Iu/Qky230Oe3ekBU6U5u6Pp89iuICngZF4l/70pVZtRgrkiocJke/njHaRiB1CFN7Ir4
         DaTaqjFJ4U/9gMBWLLvHvaGQTYCnpWmSA50nJPQ4W8/oq3FFOwUSSgfFfyoYC9GSMvOG
         CdIIKugZMYmLG/LNJMcgj7vHGvIRxddcuCE+KQiB+UNO4hpWXWV2te6SsXMiTkU3sUPe
         ul/Q==
X-Received: by 10.43.168.6 with SMTP id ng6mr46820419icc.66.1435270225803;
        Thu, 25 Jun 2015 15:10:25 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:3512:3582:e5d3:22a9])
        by mx.google.com with ESMTPSA id l128sm20425634iol.1.2015.06.25.15.10.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 25 Jun 2015 15:10:25 -0700 (PDT)
In-Reply-To: <xmqqk2urwjmq.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Jun 2015 14:41:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272741>

Junio C Hamano <gitster@pobox.com> writes:

>> +Only the first bisection following the `git bisect terms` will use the
>> +terms. If you mistyped one of the terms you can do again `git bisect
>> +terms <term-old> <term-new>`.

This paragraph may need further polishing.

The first sentence makes it sound as if this is a valid sequence,
but I do not think that is what you meant:

    $ git bisect start master maint
    $ git bisect bad
    $ git bisect terms new old
    $ git bisect old
    $ git bisect bad

I think what you wanted to say was that "git bisect terms" is in
effect during the single bisect session, and after you are done with
"git bisect reset", the next bisect session, unless you use "git
bisect terms", will use "bad" and "good", as that is the default
pair of terms.

The second sentence may want to be something like

	If you mistyped one of the terms, you can do another "git
	bisect terms <term-new> <term-old>" to correct them, but
	that is possible only before you start the bisection.

Otherwise, you invite this

    $ git bisect start master maint
    $ git bisect terms new olf
    $ git bisect olf
    $ git bisect new
    $ git bisect old
    ... error message that says you can give either "new" and "olf"
    $ git bisect terms new old
    $ git bisect old

which may not work well.
