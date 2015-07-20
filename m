From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] doc: give examples for send-email cc-cmd operation
Date: Mon, 20 Jul 2015 15:59:13 -0700
Message-ID: <xmqq615exwou.fsf@gitster.dls.corp.google.com>
References: <1437416790-5792-1-git-send-email-philipoakley@iee.org>
	<1437416790-5792-5-git-send-email-philipoakley@iee.org>
	<xmqqoaj6y50b.fsf@gitster.dls.corp.google.com>
	<996C8C8A69844E44890D09811C57DAC8@PhilipOakley>
	<xmqqa8uqxxpn.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "Git List" <git@vger.kernel.org>,
	"Eric Sunshine" <sunshine@sunshineco.com>
To: "Philip Oakley" <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Tue Jul 21 00:59:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZHK1s-0002nt-Nd
	for gcvg-git-2@plane.gmane.org; Tue, 21 Jul 2015 00:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbGTW7Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2015 18:59:16 -0400
Received: from mail-pd0-f182.google.com ([209.85.192.182]:35236 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752633AbbGTW7P (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2015 18:59:15 -0400
Received: by pdrg1 with SMTP id g1so108319968pdr.2
        for <git@vger.kernel.org>; Mon, 20 Jul 2015 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=eUDmbYO8EUevQ3Rd9GGO3Tv4/TFWJiTpNgN221csngc=;
        b=RwhlGpp3YWvA4GOVkfi4BYg0ZWmdu7Mw078pFBslzqjf1R5jcY5gLgeOW4sV/rQro1
         +foIsFO+/q8yiu/lyVZLZ/nywtA23ziFsQMUuWPsJ2nxccvPZ8/rwP2iiaMmij7woeNe
         XpkEHgIuYYrb5onTilZyN8is5X588yJXZdFSHej2zOtw7UL8vIQYOFT5jPH0WPXNmDns
         oXdXw83rSZDxKJEYHHBiUg+kDR1yGV8mYZ74wKZT8DjqudosJx3LaloO78sYf+SkWw6c
         UMdMCSFW2wBCRxg37fhSoBkd9/AG3XjZP7My4CVATnA4VwIUuhQw5wswQ9jimaaZKh6k
         tGhQ==
X-Received: by 10.70.37.144 with SMTP id y16mr65102696pdj.86.1437433154963;
        Mon, 20 Jul 2015 15:59:14 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:d4dc:19bb:f338:713b])
        by smtp.gmail.com with ESMTPSA id c5sm23667901pds.87.2015.07.20.15.59.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 Jul 2015 15:59:14 -0700 (PDT)
In-Reply-To: <xmqqa8uqxxpn.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 20 Jul 2015 15:37:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274360>

Junio C Hamano <gitster@pobox.com> writes:

>> I was trying to use, essentially, 'cat list.txt' as the command,...

One thing that needs to be made clear is that I do not think we want
to encourage `cat list.txt #` abuse in the first place.  It is an
unacceptable hack for us to encourage in the longer term.  It may
happen to work with the current implementation, but it does so
merely by depending on the implementation too much.

If it is so common to want to spray all your patches to exactly the
same list of recipients that is unconditionally determined, having
multiple sendemail.cc configuration variables, which are cumulative,
is already one way to do so, and you do not have to type such a long
option "--cc-cmd='cat $filename'" every time.

And if you do not want configuration for some reason, and having a
list of addresses in a flat file is so common, we could have a new
option "--cc-list=$filename" to support that use case.  I however
doubt anything that starts with "First you make a list of addresses
in a flat file, and then do this" is a good solution.

I would think that it would probably be the best way to address "I
often want to cc these recipients, but not always" is to keep a list
of aliases, each entry of which expands to the recipients, and say
"--cc=group" from the command line to have it expanded to the set of
recipients.
