From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Mon, 22 Jul 2013 04:12:50 -0400
Message-ID: <CAPig+cTh2t_Rc13U_F-prmm=sjs2OEHX5AX2DbC5DH+Tx_E5jg@mail.gmail.com>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
	<51DC6B37.9030108@alum.mit.edu>
	<7vli5fv5ud.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 22 10:13:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1BF2-0007a9-6c
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jul 2013 10:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756025Ab3GVING (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jul 2013 04:13:06 -0400
Received: from mail-la0-f44.google.com ([209.85.215.44]:52521 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753885Ab3GVINE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jul 2013 04:13:04 -0400
Received: by mail-la0-f44.google.com with SMTP id er20so5063517lab.17
        for <git@vger.kernel.org>; Mon, 22 Jul 2013 01:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=EyVQf4C4Z2aw5O/TAaXT+6DzH7J23vmClJsTbmSCKl8=;
        b=oEH2KLEP/D6bbdyurCPWXMK9yCh1xac1Njy3p3XOkFEDNyGMnnS2KVzvryC/DTW8PX
         JMqWvvMqZEjA8DWRgpa85kfOQ4C/sf44o9rffgWZet+mFTeXhF6Qn9tudqYKq4KPfRFT
         cGGSTu0GSO1XdR0MLHdQpBM+ok+xVMQiTDJDTvroSQgYZTWh9WnbRxXNGnyJ8BeeVJBB
         v5BSW8vsnQz5RkWbWlMnsA/SIA6Am7/2V+YqUCVZW1eCgNtUtLA85Gk7VCR42YLpBoNd
         lo19NTidnCesM+2lgyAyo48TXwd8LuHYY+IQFpH1t8tiz7FzWKE8OWK0UiBAhaO8rtHl
         oHdQ==
X-Received: by 10.112.77.164 with SMTP id t4mr11660569lbw.52.1374480770510;
 Mon, 22 Jul 2013 01:12:50 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Mon, 22 Jul 2013 01:12:50 -0700 (PDT)
In-Reply-To: <7vli5fv5ud.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: P263suKXnh-PaILP2F3VRIkPDCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230967>

On Tue, Jul 9, 2013 at 4:25 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> It would be more general to support "follow the second match to /A/"
>> *independent* of whether the first match is also followed.  I think your
>> proposal only allows the second to be followed if the first is also
>> followed.  Therefore it seems to me that your wish is to add a
>> side-effect to one feature so that you can use it to obtain a simulacrum
>> of a second feature, instead of building the second feature directly.
>>
>> Perhaps allow <start> and <end> to be a sequence of forms like
>>
>> /A//A/,+20
>
> Remember "A" is just a placeholder and in real life it would be more
> than one character.  It is just as annoying as hell you have to type
> it again.
>
> I am not saying that a mode that resets the "start searching from
> here" pointer to the beginning of the file is useless.  For example,
> I would not mind typing a special character, e.g.
>
>     -L <begin1>,<end1> -L !<begin2>,<end2>
>
> that resets the search pointer to the beginning, for a rare case
> where I want the search for <begin2> to restart at the top.
>
> But the thing is, the default matters.  And it is far more common,
> at least to me, when I want to say "from here to there, and then
> from here to there", to expect the second "from here" would be below
> the first one I already specified, while I am looking at the current
> state of a single file from top to bottom and notice two places I am
> interested in.

The proposal currently is only for "-L /RE/,whatever" to behave in a
relative fashion, beginning the search at the end of the last range
specified via -L (or line 1 if there is no previous -L).

Would it also make sense to support "-L +N,whatever" as relative to
the end of the last range specified via -L (or 1 if none).

I ask because the implementation changes needed to also support "-L
+N,whatever" appear to be less invasive than those only allowing "-L
/RE/,whatever/" to be relative. On the other hand, supporting "-L
+N,whatever" requires more documentation. I don't necessarily consider
less invasive changes as a good reason to support "-L +N,whatever" but
it got me thinking about it.
