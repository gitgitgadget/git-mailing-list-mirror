From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: Unable to shrink repository size
Date: Thu, 6 Mar 2014 08:46:10 +0100
Message-ID: <20140306074610.GO24892@paksenarrion.iveqy.com>
References: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 06 08:44:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLSyF-00061C-UV
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 08:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751147AbaCFHnz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Mar 2014 02:43:55 -0500
Received: from mail-lb0-f176.google.com ([209.85.217.176]:41245 "EHLO
	mail-lb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaCFHny (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 02:43:54 -0500
Received: by mail-lb0-f176.google.com with SMTP id 10so1454155lbg.21
        for <git@vger.kernel.org>; Wed, 05 Mar 2014 23:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=7grzU4Hg5/dLjxVLJ4/5o/HYHtkC0qiFQI7Q90jYCeo=;
        b=MZNZXh7goZBxmmypauujXgvlK3/F2xmBz5ihAC+WnqzHsRqlAwJw52cc2FlabPnVs/
         unMJvHSQRwikdi6+ThhY6k66cE1WH9zjH4ZfG3ZvHmdhaZuSC2i3ZYMnvtpQ7typeTQ3
         5xjZRmdO/Z8qYrC85FLMk/7NFPpFkgOB0SXP6vy2VuIqQwq8ALJ5r1uUmbJ/PVGwogO3
         2JI7TEY+hMDbmPZqEXi4GfcteSzD0DxnbAmfAsG9+0CkXU3uJ+F3Y72vW9kxnxe6auRn
         hOf+AlhL7g3wRZJvP69GE664vPT+Vq5/RGlvJ3Is2j7qhDPVCmgQ1gmfsJ5kuvkinMsv
         2otg==
X-Received: by 10.152.205.11 with SMTP id lc11mr6999273lac.29.1394091833021;
        Wed, 05 Mar 2014 23:43:53 -0800 (PST)
Received: from paksenarrion.iveqy.com (c83-250-237-167.bredband.comhem.se. [83.250.237.167])
        by mx.google.com with ESMTPSA id o10sm7516528laj.2.2014.03.05.23.43.51
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 05 Mar 2014 23:43:52 -0800 (PST)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1WLT0M-0007TX-Mx; Thu, 06 Mar 2014 08:46:10 +0100
Content-Disposition: inline
In-Reply-To: <CAHd499AW6nev81iVVhuoYfT0us28SSBDwbHCBa3teYB=cJR99g@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243501>

On Wed, Mar 05, 2014 at 08:55:30PM -0600, Robert Dailey wrote:
> What I'd like to do is somehow hunt down the largest commit (*not*
> blob) in the entire history of the repository to hopefully find out
> where huge directories have been checked in.
>=20
> I can't do a search for largest file (which most google results seem
> to show to do) since the culprit is really thousands of unnecessary
> files checked into a single subdirectory somewhere in history.
>=20
> Can anyone offer me some advice to help me reduce the size of my repo
> further? Thanks.

I'm not sure if you can do this with git. However since git is a comman=
d
line application it's pretty easy to script it with sh. The negative
part beeing the lack of speed, but since this is a one-time thing I
don't think that it matters.

Since you told us that it is a commit with a huge number of files that
you're looking for, I took that approach instead of calculating the siz=
e
of each commit, since that would be more expensive to do.

for commit in $(git log --pretty=3Doneline | cut -d " " -f 1)
do
	nbr=3D$(git show --pretty=3D"format:" --name-only $commit | wc -l)
	echo "$nbr: $commit"
done | sort | tail -1

This will give you the commit with most files changed. (Although, there
will be a +1 error on the number of files edited).

--=20
Med v=E4nlig h=E4lsning
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
