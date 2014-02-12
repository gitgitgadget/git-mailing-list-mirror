From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 12:59:56 +0100
Message-ID: <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Stefan Zager <szager@chromium.org>
X-From: git-owner@vger.kernel.org Wed Feb 12 13:00:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDYUd-0007uY-Ry
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 13:00:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbaBLMAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 07:00:39 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:61507 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbaBLMAi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 07:00:38 -0500
Received: by mail-ob0-f176.google.com with SMTP id gq1so10363201obb.35
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=E9XEp4Wxzhzp7Vs+OXpCM13zZGhVVSXpKzeJS0nHSnc=;
        b=0EtJbDcZgRIhO5vh/pTPsQf240xWqlgZkjXSGWvSgO4eE86XzAeEXZb9RX/IRVeXDj
         R67mm4IEr1Ow+J67S9cpG5zlLywfCEA/JC7GUlaQ9Q0UqAABruvyI76BXfOuC+n5fq+B
         mY+rVsP95eE3pECYkQEchFuF/I8AfBUkaDwQCv9XyUQrmJ100xtRxhnHBILiwGk58JrH
         y3O4wThzO0I74bMyS+uVdNcmT2gxmm9kpL6BU74yvnfxJUn4LvVoY0ZXkURAXMuPMbjX
         H0oTVQ+2ujIDUnL9zh2gyU1VkmsNc47uRFwcL23MjxrKpPXwVWhhjTV+WsW2vPuaYprO
         dR+Q==
X-Received: by 10.182.113.195 with SMTP id ja3mr12026647obb.46.1392206436198;
 Wed, 12 Feb 2014 04:00:36 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Wed, 12 Feb 2014 03:59:56 -0800 (PST)
In-Reply-To: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241986>

On Wed, Feb 12, 2014 at 2:54 AM, Stefan Zager <szager@chromium.org> wrote:
> We in the chromium project have a keen interest in adding threading to
> git in the pursuit of performance for lengthy operations (checkout,
> status, blame, ...).  Our motivation comes from hitting some
> performance walls when working with repositories the size of chromium
> and blink:
>
> https://chromium.googlesource.com/chromium/src
> https://chromium.googlesource.com/chromium/blink
>
> We are particularly concerned with the performance of msysgit, and we
> have already chalked up a significant performance gain by turning on
> the threading code in pack-objects (which was already enabled for
> posix platforms, but not on msysgit, owing to the lack of a correct
> pread implementation).

How did you manage to do this? I'm not aware of any way to implement
pread on Windows (without going down the insanity-path of wrapping and
potentially locking inside every IO operation)...
