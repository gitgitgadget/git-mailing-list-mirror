From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/9] ref-filter: add %(refname:lalignX) option
Date: Sun, 28 Jun 2015 00:39:52 -0700
Message-ID: <xmqqsi9ce0xj.fsf@gitster.dls.corp.google.com>
References: <CAOLa=ZSsVqFy4OrSt295qAZdjKTC7z44EVsx3cPEd2jb8Y-sHw@mail.gmail.com>
	<1435232596-27466-1-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, christian.couder@gmail.com,
	Matthieu.Moy@grenoble-inp.fr
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 09:40:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z97C7-0007Cn-6M
	for gcvg-git-2@plane.gmane.org; Sun, 28 Jun 2015 09:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbbF1Hjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2015 03:39:55 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:36733 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbbF1Hjy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2015 03:39:54 -0400
Received: by iecvh10 with SMTP id vh10so98380515iec.3
        for <git@vger.kernel.org>; Sun, 28 Jun 2015 00:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=GRUxIE4ANEcqPKhu1ySlO0N9byoZIu1mvhuqio3pd5Y=;
        b=Lgdqo4E5hOBwMtasgAOyA5f/JHwOtZLXFQczRiPZbl5TYbWggKl4OZvgLZxkrxb4Nd
         8QsbSOiy8/bEnJNIOR48tChbss4YboxQE0FGW59rFuoHXu4Ow/DN0QFQ5AwUkPNZNN3L
         7YLZd87jzmwv6yP0cK8RCdgdHV6Z5c7jeiKXj4B+DnqCLxjQCajpVsXau/vZVbkHh1lc
         sb9tscA4msIogkMbX21LwTU9vrP8R1LMDBEVbaXLGGSw7eZHncyvcbGmly5dna82Irwx
         LPMYVxoUZh9laxF/b8RshVodhMxhlktzN3k2QMIr1d9f/BjgJhdnaFqcdtE5yV8a8AcC
         obEQ==
X-Received: by 10.43.173.70 with SMTP id ob6mr11816150icc.45.1435477193760;
        Sun, 28 Jun 2015 00:39:53 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:205e:4a52:83c1:a37f])
        by mx.google.com with ESMTPSA id 191sm24978264iof.18.2015.06.28.00.39.52
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 28 Jun 2015 00:39:53 -0700 (PDT)
In-Reply-To: <1435232596-27466-1-git-send-email-karthik.188@gmail.com>
	(Karthik Nayak's message of "Thu, 25 Jun 2015 17:13:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272872>

Karthik Nayak <karthik.188@gmail.com> writes:

> Add support for %(refname:lalignX) where X is a number.
> This will print a shortened refname aligned to the left
> followed by spaces for a total length of X characters.
> If X is less than the shortened refname size, the entire
> shortened refname is printed.

Why would we even want this kind of thing in the first place?  Is
this to make it possible to re-implement some option that exists
already in 'git branch' or 'git tag' as a thin wrapper on top of
this underlying feature?

As a low-level plumbing, I'd rather not to see such an elaborate
formatting option added to for-each-ref; after all, the design of
the command to allow its output properly script-quoted is so that we
can offload such non-essential (meaning: does not need anything only
Git knows; computing the display width of a string and filling the
output space is an example.  As opposed to something like --merged
that needs help from Git, which has the ultimate knowledge on the
topology) processing to Porcelain that uses the command as plumbing.
