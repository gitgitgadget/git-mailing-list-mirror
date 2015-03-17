From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [GSoC] Applying for conversion scripts to builtins
Date: Tue, 17 Mar 2015 08:22:58 +0800
Message-ID: <CACRoPnQDopKNW2oc=UiLhupBBSh5ZmUHR7hU5aeguD4OVd1uPQ@mail.gmail.com>
References: <CAHLaBNJkL1CUJEk=cH=CLcDvZtoAr+PiCo2KHjfMLUKsugtRPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	johannes.schindelin@gmx.de
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 01:23:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXfHm-0008FK-SB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Mar 2015 01:23:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754154AbbCQAXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 20:23:00 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:34573 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbbCQAW7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 20:22:59 -0400
Received: by lagg8 with SMTP id g8so54169997lag.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 17:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QCYiJDeDj0/Z58uxMGSwJgm9tkWSAj35z+wH79LQ0n0=;
        b=nS7p0F5sZlvBXBz18VlMnlbE2KZC+aMjypqqPUXRGE+4JEUy7XfcN/78R/g7PY5ll4
         xzZQbmUe++b/16kYT95QI9HH5rSU5jbGxPnAVaII9Xa9QuvN0XunJE+ObvAutHlC3DUw
         rhyIu2tuoj58TiT4SwyEH2rIH6yIey0wGUtC60bQNx6SCgkndOzC3ja0mqgNv/LWLQ1E
         WzrF6ePoEhxvHOGSHnG9MuArfg8ZgVb25h1r4kBwCfRkgQyOR5i/KpGBHtagetdslh9M
         sjHIYLBXngCUXthA9b0ebmtbU72BL3zGDGyDgc/SuptsqRDLv3e4p8ki5zfyOx5K/Oz4
         FMNw==
X-Received: by 10.112.130.39 with SMTP id ob7mr59271272lbb.32.1426551778054;
 Mon, 16 Mar 2015 17:22:58 -0700 (PDT)
Received: by 10.112.130.228 with HTTP; Mon, 16 Mar 2015 17:22:58 -0700 (PDT)
In-Reply-To: <CAHLaBNJkL1CUJEk=cH=CLcDvZtoAr+PiCo2KHjfMLUKsugtRPA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265601>

Hi,

On Tue, Mar 17, 2015 at 12:49 AM, Yurii Shevtsov <ungetch@gmail.com> wrote:
> I'm going to write for this idea. As I know good proposal should
> contain timeline and Todo estimations. What should I write in my
> proposal, since there is no clear plan for converting scripts to
> builtins. Thanks in advance!

I'm actually writing a proposal for the same topic because I somehow
ended up with a working prototype of git-pull.c while exploring the
internal git API ;). It's not ready as a patch yet though as there are
some problems with git's internal API which causes e.g. double free
errors and too much code complexity due to required functionality not
being exposed by builtins, which will have to be addressed.

Generally, it would be easy to convert any shell script to C by just
using the run_command* functions (and in less lines of code), but that
would not be taking advantage of the potential benefits in porting
shell scripts to C. To summarize the (ideal) requirements:

* zero spawning of processes so that the internal object/config/index
cache can be taken advantage of. (and to avoid the process spawning
overhead which is relative large in e.g. Windows)

* avoid needless parsing since we have direct access to the C data
structures.

* use the internal API as much as possible: share code between the
builtins (e.g. fmt-merge-msg.c, exposed in fmt-merge-msg.h) in order
to reduce code complexity.

The biggest wins would definitely be portability, but there may be
performance improvements, though they are theoretical at this point.

I'm not exactly sure if the above requirements are sane, which is why
I'm also CC-ing Dscho who knows the problems of git on Windows more
than I do.

Regards,
Paul
