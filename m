From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v4 20/45] cherry-pick: copy notes and run hooks
Date: Sun, 9 Jun 2013 12:29:31 -0500
Message-ID: <CAMP44s0c-MCHSQSrx7qJaTSMTArv-Sfpi9nZSvPjmrLfVgMpQQ@mail.gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
	<1370796057-25312-21-git-send-email-felipe.contreras@gmail.com>
	<871u8bdwrb.fsf@hexa.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:29:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljQv-0003m3-RW
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:29:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab3FIR3e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:29:34 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:47226 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab3FIR3d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:29:33 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so5078440lab.14
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 10:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=O5iLKop9TV/txGpy2w3NeWXG1kQP6OL49fQCYpA03XQ=;
        b=L+wMD69wXLTRbl/GA+9roB3ctIO6pzg6XIu9ITQI/Cpc1EpMuZgrBlfltRDVDLRvsI
         h6rB7sgKafxbloHkpxkw2Hw4cqus3NiPKO3dEdcE7pFy2XaU6Epppf1GwCW8ym30uxdA
         AfwQzIg1Fv6qcF8hxHW2Z+E8j+x3CNYMV0/X/IJC4Io+RojtgoX1W+MWAx7UjUg3ICRF
         1eTXUXAxfY8j/HatJ61CTW4Xs7YJ5YRsmAzBJIp4XI8ot6vy8tVAUqwFnloGgTv5DEJ3
         JU5R7sEUD7Z3EGFIKkXZ0gIkQjQhYyc+aRohQmIZu3ug2sFEgwjsmnj73dVSwkFgiNjN
         Fe9A==
X-Received: by 10.112.156.5 with SMTP id wa5mr4903749lbb.63.1370798971860;
 Sun, 09 Jun 2013 10:29:31 -0700 (PDT)
Received: by 10.114.59.202 with HTTP; Sun, 9 Jun 2013 10:29:31 -0700 (PDT)
In-Reply-To: <871u8bdwrb.fsf@hexa.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227037>

On Sun, Jun 9, 2013 at 12:22 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +static void finish(struct replay_opts *opts)
>> +{
>> +     if (opts->action != REPLAY_PICK)
>> +             return;
>> +
>> +     run_rewrite_hook(&rewritten, "cherry-pick");
>> +     copy_rewrite_notes(&rewritten, "cherry-pick");
>> +}
>> +
>
> Ok, so I see that with the previous two commits, you automatically get
> handling of the notes.rewrite.cherry-pick variable and friends.  This is
> good.
>
> However, there are some open points:
>
> * The docs in git-config(1) "notes.rewrite.cherry-pick" and githooks(5)
>   "post-rewrite" and are now stale in so far as they contain a list of
>   commands doing rewriting.

Fine.

--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -28,9 +28,9 @@ static void finish(struct replay_opts *opts)
        if (opts->action != REPLAY_PICK)
                return;

-       name = opts->action_name ? opts->action_name : "cherry-pick";
+       name = opts->action_name

-       if (!*name)
+       if (!name || !*name)
                return;

        run_rewrite_hook(&rewritten, name);

Now, we won't run when 'git cherry-pick' is called, only when an
action-name is specified; when called from 'git rebase'.

> * This pretends to be cherry-pick even when the hook is called from
>   rebase.

No.

http://mid.gmane.org/1370796057-25312-31-git-send-email-felipe.contreras@gmail.com

> * githooks(5) documents explicitly that by the time post-rewrite is
>   called, the notes have been rewritten.  Your change does it in the
>   opposite order.

OK.

But it doesn't matter, because the patch won't be applied.

-- 
Felipe Contreras
