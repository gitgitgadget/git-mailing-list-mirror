From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: feature request: git add--interactive --patch on regex-matched
 hunks only
Date: Tue, 26 Jul 2011 19:44:06 +0700
Message-ID: <CACsJy8Birqg2Ldp1Mt4NWOq1aT0oigTcFA8S=RWcK5y+zstwDA@mail.gmail.com>
References: <CACsJy8B1B25DZ1yrzHq69vwgzQyM2ouTXCHb8oPRpb_cAX+JZQ@mail.gmail.com>
 <20110725215553.GA23145@sigill.intra.peff.net> <CACsJy8Db_sYFsQ2GcbcumJJYrXZDkKmuuULSM0_Z=HWvbYh8Bg@mail.gmail.com>
 <20110726051411.GB25046@sigill.intra.peff.net> <CACsJy8Ay1wPXAx61_rGymHDJ=YGywAy=9epiXRfJ9e68np8x6g@mail.gmail.com>
 <20110726060903.GA29486@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 26 14:44:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qlh08-0002pK-0e
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jul 2011 14:44:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296Ab1GZMoj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jul 2011 08:44:39 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35228 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751840Ab1GZMoh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jul 2011 08:44:37 -0400
Received: by ewy4 with SMTP id 4so378658ewy.19
        for <git@vger.kernel.org>; Tue, 26 Jul 2011 05:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=I4rfQPb4rAa6JM3Ma5jXEfepGv3+BPLKjy3p6UjUy3A=;
        b=JeISQ8B2Rhc0u3pKdMtNRD2gVTy260ag1uCAXEtjOOJYuuae3V0Ki5NOkA/inDDuKP
         zASBIHs4APm0RMbTm6XlmoE4kmxen0RGSUJ+C0liM6xhUBMhUMyHSsIZE0Wc9+KyvYwG
         BHbS89dI/uWNSAjfCE2kPtGG6SZCS66WubL9E=
Received: by 10.204.131.213 with SMTP id y21mr1027068bks.88.1311684276133;
 Tue, 26 Jul 2011 05:44:36 -0700 (PDT)
Received: by 10.204.121.142 with HTTP; Tue, 26 Jul 2011 05:44:06 -0700 (PDT)
In-Reply-To: <20110726060903.GA29486@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177864>

On Tue, Jul 26, 2011 at 1:09 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 26, 2011 at 12:57:46PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> It's my itch. I'm more than happy if you take care of the Perl part,
>> I'll do the rest. While you're doing the Perl part, should we have
>> both --match and --no-match? One filters in. The other filters out. =
I
>> guess people may find filter-in case more helpful than the other.
>
> Yeah. Also, what about grep options like case-insensitivity? I don't
> want to go too overboard with adding options that are unlikely to be
> used. It is perl, so technically you can do "(?i:foo)" to match "foo"
> case-insensitively.

Or even standard regex with [Ff][Oo][Oo]. We can wait until users
complain about the lack of feature. I won't complain because I may
need to match non-ascii letters (unless pcre does support unicode,
then yes pleasssse)

> I don't think there's a way to do --no-match style negation in the
> regex itself, though.

Your coding skills are needed :)

>> I thought of this way initially, but I needed to split hunks in
>> parse_diff and was stuck because I was not familiar with data
>> structure used in git-add--interactive.
>
> Oh yeah, you mentioned splitting before. I'm not sure how that would
> interact with this feature. In some cases, you'd want to split as muc=
h
> as possible, and in other cases, you'd want a bigger hunk. So I actua=
lly
> think it is an orthogonal feature to "autosplit" hunks before we show
> them to the user. I.e., something like:
>
> =C2=A0git add -p --autosplit-hunks --hunk-match=3D...

Yep. Sometimes I do want --autosplit-hunks alone.

> (where maybe the names could be better, but hopefully you get the
> point).

Speaking of names, I'm usually bad at naming, but here goes. How about
--hunks=3Dregex, --no-hunks=3Dregex and --split-hunks? We may have
--[no-]case-hunks later on but that does sound bad.

<over-engineering>maybe we should support multiple --hunks (or
--no-hunks, but not a mix of them), all must be matched, because there
are many lines in a hunk and people may want set patterns across
lines</over-engineering>
--=20
Duy
