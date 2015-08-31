From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] submodule: implement `module_name` as a builtin helper
Date: Mon, 31 Aug 2015 13:35:09 -0700
Message-ID: <xmqqwpwbtcw2.fsf@gitster.mtv.corp.google.com>
References: <1441048767-29729-1-git-send-email-sbeller@google.com>
	<1441048767-29729-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: peff@peff.net, git@vger.kernel.org, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 22:35:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWVnR-0005CQ-Vp
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 22:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752686AbbHaUfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 16:35:12 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34937 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752178AbbHaUfL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 16:35:11 -0400
Received: by pacdd16 with SMTP id dd16so150082860pac.2
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 13:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=aIbllJYgXIBvWRATGeedF25wDZ2spGzqWDoBLUlseEA=;
        b=w3W0N0P7PbpZvsNwgAIHsm8Y7uZh5ht9tsU0mdaVqAkjuMkT1h1YcK4LYGYFUPuf65
         9JQbdeWQe0UYdhal0wYxgZzkQ0DQhQEi3pUZoA61eA0AXvgfWRGBa/ScMaCpd46IIPHg
         aeDO7esCmqHJBkc2c+vS2qv76XsrsdFF6DjsY1mfeNcRo9NcB3wyC/k9MOBVIs6yaIX7
         XCc5Nxu3mv5f93uVSPPenVEuPu9KJRIyEtFv/Poxa8WrCMLUwOIcgkpQNUDwpGik/O6x
         dRZc8+iXtPDso5V1VbVL5xU2XWiHmsbXGjW4jYKp2w7hUAAkMpQ4HqSA4mS73HMekGaM
         /jCQ==
X-Received: by 10.68.203.42 with SMTP id kn10mr41139170pbc.43.1441053310749;
        Mon, 31 Aug 2015 13:35:10 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:1937:16f4:ede1:6d38])
        by smtp.gmail.com with ESMTPSA id n9sm15573970pdi.88.2015.08.31.13.35.09
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 31 Aug 2015 13:35:09 -0700 (PDT)
In-Reply-To: <1441048767-29729-3-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 31 Aug 2015 12:19:26 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276935>

Stefan Beller <sbeller@google.com> writes:

>  usage:
> -	usage("git submodule--helper module_list\n");
> +	usage("git submodule--helper [module_list | module_name]\n");

To me, the above reads as if saying:

    The command takes one of the two subcommands at this stage,
    module_list that does not take any parameter, and module_name
    that does not take any parameter.

which is not what you intended.

I think that the help for individual options and arguments are
sufficiently given in the implementation of each subcommand
(e.g. module_list does its own parse_options() thing), so there is
no need to duplicate them here.  The only purpose of this usage serves
is to tell the user that the subcommand name was not understood, and
give the list of available subcommands.  For that, I wonder if the
usual single-liner "usage" is the best way to do so.

    $ git submodule--helper frotz
    fatal: 'frotz' is not a valid submodule--helper subcommand, which are
           module_list, module_name.

or something along that line, perhaps, may be more appropriate?
