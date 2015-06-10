From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 7/7] send-email: suppress leading and trailing whitespaces before alias expansion
Date: Wed, 10 Jun 2015 08:15:10 -0700
Message-ID: <xmqqa8w7oarl.fsf@gitster.dls.corp.google.com>
References: <1433875804-16007-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<1433875804-16007-2-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
	<vpqa8w89d5x.fsf@anie.imag.fr>
	<1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 10 17:15:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2hio-0008S1-81
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 17:15:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbbFJPPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 11:15:14 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:35698 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbbFJPPM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 11:15:12 -0400
Received: by iesa3 with SMTP id a3so36552000ies.2
        for <git@vger.kernel.org>; Wed, 10 Jun 2015 08:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=OwUgIsXSekqBmHsohORCbSmQna2qVTkuVR51tFTYMM8=;
        b=YARHmPbDqvkB5mq6uYNHk1u583aYOx8umwlDvbk/FK56zD+vLCGzSJnqTBFDjo+syL
         dSILGVzlqEhEBmEH0YTTR62Q1oKCGArBfuETl7uLwjcxLqOdnkjajO3z920MEsr1cST7
         QTvfeY9oAxgXNlbZsMy63n9X93SjvKLlAxUEA750cIX2aGhtlrm/d8rkB45oBAQa9L5s
         D+DxVj0sG/IGUUNtpmS6OlMsnh/PJ5NCsoKSmN8RJWL5GuCnn3z1sdI+KG8VUdnFeGHk
         h8RGKLOTMr2ub5CDU6H3UKLX/nBu1h204qJOJu3yXNdetOfhoUHk7SMU/AaWWQ8211ik
         Is5Q==
X-Received: by 10.43.0.67 with SMTP id nl3mr5320782icb.59.1433949311697;
        Wed, 10 Jun 2015 08:15:11 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b116:bf29:c748:758b])
        by mx.google.com with ESMTPSA id o9sm6188208ioe.35.2015.06.10.08.15.10
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Jun 2015 08:15:11 -0700 (PDT)
In-Reply-To: <1281238070.338321.1433928615479.JavaMail.zimbra@ensimag.grenoble-inp.fr>
	(Remi Lespinet's message of "Wed, 10 Jun 2015 11:30:15 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271299>

Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr> writes:

> I agree, I'd like to put it right after split_at_commas in a separate
> function "trim_list". Is it a good idea even if the function is one
> line long ?

Hmph, if I have "A, B, C" and call a function that gives an array of
addresses, treating the input as comma-separated addresses, I would
expect ("A", "B", "C") to be returned from that function, instead of
having to later trim the whitespace around what is returned.

It suggests that split-at-commas _is_ a wrong abstraction, doesn't
it?  In other words, I think whitespace trimming is part of what the
split-a-single-string-into-array-of-addresses helper function should
be doing.
