From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 0/2] Another squash on run-command: add an asynchronous
 parallel child processor
Date: Fri, 25 Sep 2015 11:56:11 -0700
Message-ID: <CAGZ79kbpLwODzPrGcuvz2oY+XMMPAy9SRh1s_5wV8cvY-J79iw@mail.gmail.com>
References: <xmqqzj0cv9v8.fsf@gitster.mtv.corp.google.com>
	<1443129187-18572-1-git-send-email-sbeller@google.com>
	<xmqq4mijuwyz.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:56:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfYAL-0003y4-VG
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 20:56:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932922AbbIYS4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2015 14:56:13 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:36407 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932889AbbIYS4M (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2015 14:56:12 -0400
Received: by ykdt18 with SMTP id t18so123695296ykd.3
        for <git@vger.kernel.org>; Fri, 25 Sep 2015 11:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KuinrtXCLH/o/osSiNEJLTEF9ISwxyX3fK18GjU1rI4=;
        b=HLyjidpSYlKGMLcJgH+DowgrFNTd5bbDsHHH0cY/lgbTki+DerbQ/OkpS+CesKM6vN
         hEhlvTX1Juvn9vXAUimB4thTVs7pdIG0ZdFGtYs7kLZhVRsNPn3TQXm6HZSgyYZoMcR+
         61It6MbDm3F036nuaivyUlMJtZCKP+A8FTA6/IsyyL8YtSaom1D84rkXhB6Ge/6hOLQT
         6KRRaE2ZyGW8rvJwXGijZIIi1S8uEIDsZCGkbpgxQPDnGce5tGnLOToUQAZPmG2KF5dE
         5O17vwTCzknZnjuCxfAteZHliaBX3eUiCw7P2FZAdpmReB4J/uLDZbi886KXR9Fv4klC
         bYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KuinrtXCLH/o/osSiNEJLTEF9ISwxyX3fK18GjU1rI4=;
        b=EecqAFFzcAtgLhl5u/gmhzZaj7/e73+6PCtJqYhaAABHrDwwC2h4XMINO4tvnXiDHO
         Gy8dQDYxOcr33XPbe3Gec5Obck++XVf6RIFwBE3eqN5R8ZcYINE+j8w0OI1I095gBLNE
         goMmMpv7YQylfzMWz2z1txYF0NjcSInoLu9hoFwchw+mqPbRj+9oLAR+lb4dv9oxLjqh
         G3j4gITZUT+tEAdmz0wDXG3f8mLN6Lj0bhAmlWmZEIwnjTj+vh4kVMVy+ULk5+jOi38T
         gS8FdpR0Lyio9zZ6PRVoaj5k+4RMnnlse7bSxr+d/kN6m1Ga4JVdb+YM4ZKiOUhpwsfV
         ODpQ==
X-Gm-Message-State: ALoCoQmoMH2tY9JmzFTTFNiBvivnNqM5zC/ZID1IXu/dNFhxhqcC4JK7ddnjJprhVODqWWADGkkW
X-Received: by 10.129.31.69 with SMTP id f66mr6294971ywf.174.1443207372009;
 Fri, 25 Sep 2015 11:56:12 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 25 Sep 2015 11:56:11 -0700 (PDT)
In-Reply-To: <xmqq4mijuwyz.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278675>

On Thu, Sep 24, 2015 at 6:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>  * If you do not die() in start_failure_fn or return_value_fn, you
>>    don't want to write to stderr directly as you would destroy the fine
>>    ordering of the processes output. So make the err strbuf available in
>>    both these functions, and make sure the strbuf is appended to the
>>    buffered output in both cases.
>
> Another thing I noticed after re-reading the above is that we shared
> the thinking that dying in these is _the_ normal thing to do and
> continuing is an advanced and/or wierd setting.
>
> And I think it is wrong.  Suppose after spawning 15 tasks and while
> they are still running, you start the 16th one and it fails to stop.
> If your start-failure called die() to kill the controller, what
> happens to the 15 tasks that are already running?
>
> I think two sensible choices that start-failure and return-value can
> make are
>
>  (1) This one task failed, but that is OK.  Please let the other
>      tasks run [*1*].
>
>  (2) There is something seriously wrong with the whole world and I
>      declare an emergency.  Please kill the other ones and exit.

  (3) There is something wrong, such that I cannot finish my
      job, but I know the other 15 processes help towards the goal,
      so I want to let them live on until they are done. E.g: fetch submodules
      may want to take this strategy if it fails to start another sub
process fetching.

By having a return value indicating which strategy you want to pursue here,
we're making the design choice to have everything done monolithically
inside the pp machinery.

We could also offer more access to the pp machinery and an implementation for
(2) might look like this:

static void fictious_start_failure(void *data,
                                void *pp,
                                struct child_process *cp,
                                struct strbuf *err)
{
        struct mydata *m = data;

        if (m->failstrategy == 1)
                ; /* nothing here */
        else if (m->failstrategy == 2)
                killall_children(pp);
        else if (m->failstrategy == 3) {
                m->stop_scheduling_new_tasks = 1;
                redirect_children_to_dev_null(pp);
        else
                ...
}

By having the pointer to the pp struct passed around, we allow
for adding new callback functions to be added later to the
pp machinery, which may not be expressed via a return code.

>
> Dying in these callbacks do not achieve neither.  Perhaps make these
> two functions return bool (or enum if you already know a third
> sensible option, but otherwise bool is fine and the person who
> discovers the need for the third will turn it into enum) to signal
> which one of these two behaviours it wants?
>
> And the default handlers should stop dying, of course.
>
>
> [Footnote]
>
> *1* Because start-failure gets pp, it can even leave a note in it to
>     ask the next invocation of get-next to retry it if it chooses
>     to.  At this point in the design cycle, all we need to do is to
>     make sure that kind of advanced usage is possible with this
>     parallel-run-command API.
