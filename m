From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCHv2 0/10] pkt-line and remote-curl cleanups server
Date: Tue, 19 Feb 2013 23:05:36 -0800
Message-ID: <CAJo=hJvrc3EUfzr2BDZ3i68rwZVeHFGHmKwrvhhMMV45DLaWzw@mail.gmail.com>
References: <20130216064455.GA27063@sigill.intra.peff.net> <20130216064929.GC22626@sigill.intra.peff.net>
 <20130217110533.GF6759@elie.Belkin> <20130217192830.GB25096@sigill.intra.peff.net>
 <20130218014113.GC3221@elie.Belkin> <20130218091203.GB17003@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 20 08:06:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U83l1-0000Fy-Ux
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 08:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933273Ab3BTHF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 02:05:58 -0500
Received: from mail-ia0-f173.google.com ([209.85.210.173]:45496 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933074Ab3BTHF5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 02:05:57 -0500
Received: by mail-ia0-f173.google.com with SMTP id h37so6921423iak.4
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 23:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=aI3K5XLkgobGDNklAa0ogHzer84eLo8l5qeMZtwAwsk=;
        b=fMNpFaA57Gf13aXMjiZjbIjLJ0x/tZZS0tVVG++LIyu+L7vVoeQ9vwrwc9ehMQosNI
         UPdK7ERBFNKzOphEh6SGEoKyI12ACy+jgLXq444GY54bnpujEdbZfX7LNJSxarqh0C16
         kYoDGk1FeawCNCMFMDV4BFck++L0YAMetkVPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:x-gm-message-state;
        bh=aI3K5XLkgobGDNklAa0ogHzer84eLo8l5qeMZtwAwsk=;
        b=iAl+/1/ie9512rk4AaZZkwaEa0AWhS3sCQqPU1ZH4LbvU9hBOiKIROmyZl1YcKIbQ8
         zFcUrm5UVexm400bJm2Yx7vM51pvW0qeaYhXyx47UfudoRxxw5Wya6WP61ydDtDOI59O
         6w2GyxL680pHUAiDkkI5O0DwEY7WH69i4qOI2VI331mFQ9WBp27bwV1i51wRqW6g9UtG
         syKm9xUJbim8vY8vr0SNBlK/dczGUtVDATSsOosXF6N+7zR3HSViWCAWTfFBjHlBtjdx
         Nze8V77wawWK0UVDZhVI0xVYFAQ/K7MOPIU8p1ZA0psk3n0VRxknhzVfWPaeagnlqsus
         mPNw==
X-Received: by 10.50.170.102 with SMTP id al6mr10918915igc.20.1361343956578;
 Tue, 19 Feb 2013 23:05:56 -0800 (PST)
Received: by 10.64.89.99 with HTTP; Tue, 19 Feb 2013 23:05:36 -0800 (PST)
In-Reply-To: <20130218091203.GB17003@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQlG/FQ2w87t0FLs5O9URsPmfufQx0jqAQpa78n1AuDPhewI65Lx47f7D4waaMgHoo0G7dTb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216686>

On Mon, Feb 18, 2013 at 1:12 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 17, 2013 at 05:41:13PM -0800, Jonathan Nieder wrote:
>
>> > I don't think so. Don't ERR lines appear inside their own packets?
>>
>> Yes, I misread get_remote_heads for some reason.  Thanks for checking.
>
> Thanks for bringing it up. I had not even thought about ERR at all. So
> it was luck rather than skill that I was right. :)
>
>> I'm not sure whether servers are expected to send a flush after an
>> ERR packet.  The only codepath I know of in git itself that sends
>> such packets is git-daemon, which does not flush after the error (but
>> is not used in the stateless-rpc case).  http-backend uses HTTP error
>> codes for its errors.
>
> I just checked, and GitHub also does not send flush packets after ERR.
> Which makes sense; ERR is supposed to end the conversation. I can change
> GitHub, of course, but who knows what other implementations exist (e.g.,
> I do not know off-hand whether gitolite has custom ERR responses). So it
> seems pretty clear that just checking for a flush packet is not the
> right thing, and we need to actually parse the packet contents (at least
> to some degree).

JGit (and by extension Gerrit Code Review, android.googlesource.com)
sends ERR with no flush-pkt. I would like to sort of keep the protocol
this way, given how many servers in the wild are running Gerrit and
currently use ERR with no flush-pkt. IMHO its a little late to be
closing that door and stuffing a flush-pkt after the ERR that ends the
conversation.
