From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: Make the git codebase thread-safe
Date: Wed, 12 Feb 2014 19:27:25 +0100
Message-ID: <CABPQNSZtQd51gQY7oK8B-BbpNEhxR-onQtiXSfW9sv1t2YW_nw@mail.gmail.com>
References: <CA+TurHgyUK5sfCKrK+3xY8AeOg0t66vEvFxX=JiA9wXww7eZXQ@mail.gmail.com>
 <CABPQNSZ_LLg5i+mpwUj7pzXVQMY1tcXz2gJ+PWG-mP1iyjxoaw@mail.gmail.com> <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stefan Zager <szager@chromium.org>,
	GIT Mailing-list <git@vger.kernel.org>
To: Stefan Zager <szager@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 19:28:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDeXc-0000RP-1f
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 19:28:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753547AbaBLS2I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 13:28:08 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:40697 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753086AbaBLS2G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 13:28:06 -0500
Received: by mail-ob0-f174.google.com with SMTP id uy5so10891307obc.19
        for <git@vger.kernel.org>; Wed, 12 Feb 2014 10:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IAMgzhfJ0XpuNardL62m9APKO2BrB6c+eClKoBqi8K0=;
        b=b2uOSm8G4aGThJaTGa5oH1+71GT6YZk7aOMcWhkKKc+qyvCIHfwgII8YWls/pYETci
         QJY04Baku9+P/oq+6H0oAaEIATqiwkvtepqdeVIDsIeNz+XptR4jGosKeygfMr1hX9wy
         EZARdmbKGOjYATs3K39eSom4B7XuPe9E0Oq8pW4Mu7kG1UBCtRV8LjVQo3oz6ibmHKBT
         DN2TbPlVRokitcWpqzXFVx/qZsd1kTvPlLLSIwV3b2EFlNWYJQNbSGlivdDDd5DahwPb
         pq2Bwif2VtGbkyOpWIDpn5gPEHWQdRxcF1MBpH5B4l5GDgCjsqb8VTmBcC6p4ayfwPHr
         pzyA==
X-Received: by 10.60.103.134 with SMTP id fw6mr38418816oeb.34.1392229686201;
 Wed, 12 Feb 2014 10:28:06 -0800 (PST)
Received: by 10.76.85.103 with HTTP; Wed, 12 Feb 2014 10:27:25 -0800 (PST)
In-Reply-To: <CAHOQ7J8QxfvtrS2KdgzUPvkDzJ1Od0CMvdWxrF_bNacVRYOa5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242004>

On Wed, Feb 12, 2014 at 7:20 PM, Stefan Zager <szager@google.com> wrote:
> On Wed, Feb 12, 2014 at 3:59 AM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>> On Wed, Feb 12, 2014 at 2:54 AM, Stefan Zager <szager@chromium.org> wrote:
>>>
>>> We are particularly concerned with the performance of msysgit, and we
>>> have already chalked up a significant performance gain by turning on
>>> the threading code in pack-objects (which was already enabled for
>>> posix platforms, but not on msysgit, owing to the lack of a correct
>>> pread implementation).
>>
>> How did you manage to do this? I'm not aware of any way to implement
>> pread on Windows (without going down the insanity-path of wrapping and
>> potentially locking inside every IO operation)...
>
> I don't want to steal the thunder of my coworker, who wrote the
> implementation.  He plans to submit it upstream soon-ish.  It relies
> on using the lpOverlapped argument to ReadFile(), with some additional
> tomfoolery to make sure that the implicit position pointer for the
> file descriptor doesn't get modified.

Is the code available somewhere? I'm especially interested in the
"additional tomfoolery to make sure that the implicit position pointer
for the file descriptor doesn't get modified"-part, as this was what I
ended up butting my head into when trying to do this myself.
