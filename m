From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] disallow test_when_finished in subshells
Date: Sat, 5 Sep 2015 10:36:29 -0700
Message-ID: <CAPc5daUsd8KD77EfF-SBwwOKn0hNPvYXo8UmY-sHBg9S4vUQXg@mail.gmail.com>
References: <20150905085429.GB25039@sigill.intra.peff.net> <cover.1441458341.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sat Sep 05 19:37:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYHOv-0005yc-C2
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 19:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752459AbbIERgv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 13:36:51 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:32997 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbbIERgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 13:36:49 -0400
Received: by iofh134 with SMTP id h134so54040776iof.0
        for <git@vger.kernel.org>; Sat, 05 Sep 2015 10:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=miiYpFnUDg4lfYTrAQNVy5F5n6qTtKcnpQHyeTWTurc=;
        b=BvZpwPPVGo9sD8jGPKWXZwK1Tn2VhstR7V7kPqpCW9LNoLtQbvJSZ8lWO4n/yD6hI9
         78z61uz38vsQSXEwvzg1NrtbTuy+rIYIINn3NTjsrzwHCu0UVslS1Wp+CF+znp1xFsK+
         jP79hE+W2eU67yTW+pBsktxra6q1K9+FzPG5Db0oaph/lPsbFCApxrxre+d8PWmhWXUO
         wiuGxtGQmY8FYlZTIZgES1MEffNzpEvwgFr/FN146B5RXl9IIBy//PdTR/m0qppIDZ9B
         bWpjq/Splw36gXSnDOhtoL4/Rrj1P4GLiX6Kp92uIpJkvRurcgpcGWklLSGoChwrObT/
         PLtg==
X-Received: by 10.107.155.78 with SMTP id d75mr17277789ioe.44.1441474608803;
 Sat, 05 Sep 2015 10:36:48 -0700 (PDT)
Received: by 10.36.79.69 with HTTP; Sat, 5 Sep 2015 10:36:29 -0700 (PDT)
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
X-Google-Sender-Auth: Xt3_Dbzzxrtk9K5cj0XcpVGmaMY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277391>

On Sat, Sep 5, 2015 at 6:12 AM, John Keeping <john@keeping.me.uk> wrote:
>
> I don't think it's worth trying to clear $BASH_SUBSHELL before the tests
> start because to do so we have to reliably detect that we're not running
> under Bash, and if we don't trust people not to set $BASH_SUBSHELL why
> do we trust them not to set $BASH?

I am not worried about evil people who do funny things to deliberately break
other people's arrangement. I am more worried about stupid people (e.g. those
who export CDPATH).

In bash a stupid person may attempt to export BASH_SUBSHELL and then
have a script that runs our test suite, setting SHELL_PATH to point at a
non-bash while building Git and running the tests under a non-bash shell. I
am hesitant to believe that we will know the variable will never leak through
to the test via environment.

Isn't it just the matter of resetting the variable regardless of $BASH
(and ignoring
a possible refusal to do so under bash) at the beginning of the test, or do you
really have to rely on the value of $BASH and do things differently?
