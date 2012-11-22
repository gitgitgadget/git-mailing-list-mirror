From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v5 15/15] fast-export: don't handle uninteresting refs
Date: Thu, 22 Nov 2012 01:28:30 +0100
Message-ID: <CAMP44s2B2_htR8LFbHk99WaNUcaYJCxVJPdRdj5VQ0k+fB9NOg@mail.gmail.com>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
	<1352642392-28387-16-git-send-email-felipe.contreras@gmail.com>
	<CAMP44s0WH-P7WY4UqhMX3WdrrSCYXUR9yCgsUV+mzLOCK5LkHQ@mail.gmail.com>
	<7vd2z7rj3y.fsf@alter.siamese.dyndns.org>
	<20121121041735.GE4634@elie.Belkin>
	<7vfw43pmp7.fsf@alter.siamese.dyndns.org>
	<20121121194810.GE16280@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:50:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbcnN-0002HC-4y
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208Ab2KVTuY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:50:24 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44603 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030200Ab2KVTuW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:50:22 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so8331820oag.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OQ5YQsKkcZ6ptA/kxDJZyfQ5j5Mhyw4XQwW1aLoHrJg=;
        b=ko2lNNBwrLlpOYYYS+/Uno/8qIG/f1c//NTYv2cfiB+e+HAGrOpncK7WnZmCf2uREs
         DM7D4pmt5lrAX3aQ9bLMn7g6FWEeOAmlx7lKz/tOk6r6QjE3p8RDHg+nJuAmAx8+q7Aw
         /bTwSC9LlxgiQcjJkVcsfHuQ7yQjYN/RVck4e3kp1JYU6hTPo8ysU0JtqXcR7W7znY/0
         dayWxFr96W2E+brt8h7wy3m3t7Tmv0G5YenuOjB2dMBUci8bHjqUBr+vprpaji7E/1w4
         HIhRqC7+iBMrbKmh/E203mJlK9xOJsRBVYod78cr7YSpM3hkDYiGt1DDg59WUy28tLh3
         O3bg==
Received: by 10.60.30.70 with SMTP id q6mr17394556oeh.103.1353544111131; Wed,
 21 Nov 2012 16:28:31 -0800 (PST)
Received: by 10.60.32.196 with HTTP; Wed, 21 Nov 2012 16:28:30 -0800 (PST)
In-Reply-To: <20121121194810.GE16280@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210203>

On Wed, Nov 21, 2012 at 8:48 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 20, 2012 at 09:08:36PM -0800, Junio C Hamano wrote:
>
>> With such a one-sided discussion, I've been having a hard time
>> convincing myself if Felipe's effort is making the interface better,
>> or just breaking it even more for existing remote helpers, only to
>> fit his world model better.
>
> Felipe responded in more detail, but I will just add the consensus we
> came to earlier in the discussion: the series does make things better
> for users of fast-export that use marks, but does not make things any
> better for users of negative refs on the command line. However, I do not
> think that it makes things worse for them, either (neither by changing
> the behavior negatively, nor by making the code harder for a more
> complete fix later).

Patch 14 changes the behavior depending on the marks, patch 15 doesn't.

This patch is mostly orthogonal to marks.

Before without marks:
% git branch unintresting master
% git fast-export master ^uninteresting
reset refs/heads/uninteresting
from :0

Before with marks:
% git fast-export --import-marks=marks master ^uninteresting
reset refs/heads/uninteresting
from :100

See? In both cases git is doing something the user doesn't want, nor
specified. After my patch nothing gets updated, because nothing was
specified to be updated.

I'm not going to bother explaining why other people objected to this
patch (again), which is indeed related to marks, they should do it for
themselves. Let me reaffirm that no valid reason has put forward to
object to this patch.

> So while fixing everybody might be nice

I would like to understand that that even means. What behavior is
currently broken? And for who? And how is this patch related to that?

> [1] There are other possible use cases for fast-export which might
>     benefit from negative refs working more sanely, but since they are
>     in the minority and are not being made worse, I think the partial
>     fix is OK.

Which ones? I don't think this is a partial fix.

Nobody has put forward such a use-case.

Cheers.

-- 
Felipe Contreras
