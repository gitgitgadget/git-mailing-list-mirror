From: "Brian Foster" <brian.foster@innova-card.com>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Mon, 5 May 2008 16:44:27 +0200
Message-ID: <a537dd660805050744h7602e553u21c70168a621fe76@mail.gmail.com>
References: <20080416062925.8028e952@zebulon.innova-card.com>
	 <20080416063739.4B72647879@blf.utvinternet.co.uk>
	 <20080505042546.GA7164@shion.is.fushizen.net>
	 <200805051608.55200.brian.foster@innova-card.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Bryan Donlan" <bdonlan@fushizen.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 05 16:45:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jt1wN-0001yG-1j
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 16:45:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbYEEOo3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 May 2008 10:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756312AbYEEOo3
	(ORCPT <rfc822;git-outgoing>); Mon, 5 May 2008 10:44:29 -0400
Received: from rv-out-0506.google.com ([209.85.198.234]:56137 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbYEEOo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 May 2008 10:44:28 -0400
Received: by rv-out-0506.google.com with SMTP id l9so1164393rvb.1
        for <git@vger.kernel.org>; Mon, 05 May 2008 07:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=+IGrH5PuvZjUyIEfw8GPA3St6UaYALc/BaeCs4+mJws=;
        b=C90Puj3zquE2MlUVXTB3NIs3O7mPcao76vz4wqtG4JD3z02Hl6lW8bNRBxCQEPu7Nu+GWwgWfxIgMhDKwzXOtKRU0EXFK7GY9cbfdeAqpaAWz+zpfmvrewP1SuRZKpc8hMh6VpyLROuv3DV6P/BXfe/dXwGouY2EQOvzrMx/RC0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=yFtZRJrpeTGlA/+fJrb6OY7bh2Ykf4UyNjDGHRhlthcKEus1EucdMKGk+BLeYm9Zn8/CVLwMYYjXO4tsVd1G3+EDANaFmfB39VaQtohcchDb80PwVk9u5NwFjQycuFKlnlRzwWtq76SzWbN3s4sTpNk0BXsdZrRSUDgPHIL3MFY=
Received: by 10.140.132.8 with SMTP id f8mr2842591rvd.122.1209998667981;
        Mon, 05 May 2008 07:44:27 -0700 (PDT)
Received: by 10.141.197.19 with HTTP; Mon, 5 May 2008 07:44:27 -0700 (PDT)
In-Reply-To: <200805051608.55200.brian.foster@innova-card.com>
Content-Disposition: inline
X-Google-Sender-Auth: 9d95b44b145dfb99
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81287>

On Monday 05 May 2008 06:25:46 Bryan Donlan asked:
> On Wed, Apr 16, 2008 at 08:37:39AM +0200, Brian Foster wrote:
> >  I've recently inherited a bare git repository,
> >  which, as far as I can tell (I'm something of
> >  a newbie with git), seems Ok: `git fsck --full'
> >  does not report any problems.    however, any
> >  clones I make from it are not Ok [ ... ]
>
> Is there an info/grafts file?  If the repository doesn't have sensitive
> information in it, it would probably be helpful to tarball it up and
> upload it somewhere, so we can take a look at things directly.

Bryan,

 Yes, the proximate cause was an info/grafts.

 The repository in question is for a port of Linux
 to the MIPS-based "secure" SoC made by the company
 I work for.  The repository was very simple:

    master:  o---o---o---o---o--...--o  HEAD

 where each `o' was a tagged version/release of the
 Linux port.  Since the chip is MIPS-based, some `o'
 were the result of merges with mips-linux baseline.
 Hence, the real history was, broadly:

       master:          o--o--o--o--o--o-----o--...--o
                       /           /  /     /
   mips-linux:  o--o--o----o------o--o--o--o--...--o

 where, of course, `mips-linux' has its own rather
 complicated history (not shown).  As implied by
 the diagrams above, grafts were used to "suppress"
 mips-linux and its history.  (Since the situation
 really was as trivial as drawn above, it was easy
 to recover:  Add the pack representing mips-linux,
 remove grafts, and ensure all the tags exist.)

 What I don't know is the root-cause, that is, WHY
 this was done.  It wasn't a disc-space issue, and
 I've no evidence it was a network-bandwidth issue,
 but there is some anecdotal evidence it was some
 sort of a CPU-cycles issue, albeit just what the
 performance hit was is unknown.

 Another possibility is the repository started life
 as CVS (ugh!) before being migrated to git.  It's
 my (vague) understanding grafts is somehow useful
 as a (temporary?) aid when doing a CVS-->git move;
 and I speculate it was found so useful/simple the
 practice simply continued.

 The developers tended to work from tarballs (not
 clones), so the cloning problem was either unknown,
 not a concern, or mis-understood.

cheers!
	-blf-

-- 
"How many surrealists does it take to   | Brian Foster
 change a lightbulb? Three. One calms   | somewhere in south of France
 the warthog, and two fill the bathtub  |   Stop E$$o (ExxonMobil)!
 with brightly-coloured machine tools." |      http://www.stopesso.com
