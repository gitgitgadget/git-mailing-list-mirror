From: Shawn Pearce <spearce@spearce.org>
Subject: Re: PROPFIND 405 with git-http-backend and Smart HTTP
Date: Sun, 29 Jul 2012 18:00:44 -0700
Message-ID: <CAJo=hJtB6OQ8+8Q_JgPoAntOdQ=Z0tOERYRD7wJ0LRLgacYA8A@mail.gmail.com>
References: <1343587966493-7564017.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Bo98 <BoEllisAnderson@aol.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 03:01:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SveMJ-0005Pq-Aq
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 03:01:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753779Ab2G3BBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jul 2012 21:01:09 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:50848 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753685Ab2G3BBH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2012 21:01:07 -0400
Received: by yenl2 with SMTP id l2so4319453yen.19
        for <git@vger.kernel.org>; Sun, 29 Jul 2012 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=smQyOfgfcE0VsBdsRjzdIyQT0yRehl7z/Q9k+JdJ6Ls=;
        b=TrYoi52QzNlq75z3JzUstz5kNKGrcHXXB4VY9cjgfJ5poVjRzUqmpR+1/ihD8IEMHf
         1nTLtxdiJyUgoMz1DfC6qFscA72Y1yNRYzOLo0HGqFN4/5SPMqsmoH/vCDwydzPxpa92
         xiJcZUV+94bbBzG8Us7llKlAJubU/MtA1MBZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=smQyOfgfcE0VsBdsRjzdIyQT0yRehl7z/Q9k+JdJ6Ls=;
        b=gV6vGMX7sxtqanSxibnR8nuHu1bobBK399WPIU5lP/hr0sh8+f/0jKzGifJ9tlA7VR
         2FshCGN6o2YpNkj29ovsLF29M1p5YENMOX3me4eCFHd5CSwlWh99H9whk0WAZjF9PJsQ
         MH/ULl7onz5V/h0QP+OqdxLUad9C2I1yKXwy0LlyAZWzsBz87sYIJP7Q/fmR6CEwZNle
         RTwLCuNyf+3wtk+lhSkkeIl6Sy+OEOL48jv/hcAhKmn46iTeAIPJW5otACOZn3AifQsk
         jWZLFODlLoNH2CFXZmoV/Iy5YN8lqJEtUlkQdL0xvS9vDVwgdPIfaMn94jWOEV0QYe1s
         eGAA==
Received: by 10.43.92.67 with SMTP id bp3mr5774536icc.16.1343610065692; Sun,
 29 Jul 2012 18:01:05 -0700 (PDT)
Received: by 10.64.14.177 with HTTP; Sun, 29 Jul 2012 18:00:44 -0700 (PDT)
In-Reply-To: <1343587966493-7564017.post@n2.nabble.com>
X-Gm-Message-State: ALoCoQnI9KzK7R/+TuGw5ixh5wRUBHEiRdiXxCygT7oACRx28a5XRcbhksK5zR3T/vO8BjyILEBj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202511>

On Sun, Jul 29, 2012 at 11:52 AM, Bo98 <BoEllisAnderson@aol.com> wrote:
> I'm setting up a git server with git-http-backend and Smart HTTP but I'm
> getting PROPFIND Error 405 with git push.

This suggests the client didn't see the server as one supporting smart HTTP.
...
>
> And here's a snip from my access_log:
>
>     ::1 - - [29/Jul/2012:18:34:34 +0100] "GET
> /repo/myproject.git/info/refs?service=git-receive-pack HTTP/1.1" 200 117

Was this request actually served using the smart http-backend? Try the
request yourself on the command line with curl, making sure to pass
the ?service=git-receive-pack query parameter. A smart HTTP response
will include a service=git-receive-pack line as the first line of the
response body. I don't think Apache called the http-backend CGI, and
so the client thought the server was not smart HTTP capable.
