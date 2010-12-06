From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] describe: =?utf-8?B?RG9u4oCZ?= =?utf-8?Q?t?= look up
 commits with --exact-match
Date: Mon, 6 Dec 2010 01:32:14 -0600
Message-ID: <20101206073214.GA3745@burratino>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu>
 <20101203084348.GD18202@burratino>
 <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Anders Kaseorg <andersk@ksplice.com>
X-From: git-owner@vger.kernel.org Mon Dec 06 08:32:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPVYx-00068y-Vb
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 08:32:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751101Ab0LFHcj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Dec 2010 02:32:39 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57584 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab0LFHci convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Dec 2010 02:32:38 -0500
Received: by yxt3 with SMTP id 3so5306413yxt.19
        for <git@vger.kernel.org>; Sun, 05 Dec 2010 23:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=ORRZLQorhC/VZqWP9+QfjxFal0bscSKk6RVdQHEjHg4=;
        b=Lhgm4M92Ueb2ISHH2uyETREutdzBb/wF12DBJUrUAGGsGFhtDq3NoSCpt4uAMhR4r1
         XhlBDF70MFdhm6BNIVU0frdBjAFiW5K4BfvfwN89PLnB84ZLiTYEzBnmEQcS2aG//zJp
         rTl1qfNWKq330KQ/GY4cNPa5vN/Lulmmxa+j8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=CSwl1M2M7ORADefL7lCJY4TOCx0lYtkDWhKTTg2FdEM9AgfURZ/HfjcKyJlkWXq/5S
         UNNms2/LmLG9z5uWA5CTE3G61yzsONEpq3wgZx+qq3JD42rGGr0SN6jDXkKbKq3dkA73
         bmLq0LSYqw1j9+lZrZKvUaHMIgB9j7WlTFjho=
Received: by 10.90.31.16 with SMTP id e16mr7442886age.21.1291620757511;
        Sun, 05 Dec 2010 23:32:37 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id v18sm2949677yhg.15.2010.12.05.23.32.35
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Dec 2010 23:32:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162979>

Anders Kaseorg wrote:
> On Fri, 3 Dec 2010, Jonathan Nieder wrote:

>> Instead of looking up the commit to be matched exactly in the commit=
s
>> hash table, this makes a linear search.
[...]
> I don=E2=80=99t think it=E2=80=99s ever a problem: in my repository w=
ith 1800 tags on a=20
> warm cache, that loop accounts for about 0.1% of even the fastest=20
> non-exact-match query (a commit right after a tag).

Thanks for checking.  Makes sense.

>>> -	for_each_ref(get_name, NULL);
>>> +	for_each_rawref(get_name, NULL);
>>
>> Orthogonal change snuck in?
>
> This does fall under the category of =E2=80=9CDon=E2=80=99t lookup co=
mmits,=E2=80=9D and is=20
> necessary to get the speedup (otherwise for_each_ref has already look=
ed up=20
> the commits that the rest of the patch is trying to avoid looking up)=
=2E =20

Depends on what "Don't lookup commits" means, I suppose.  I
think the difference between _ref and _rawref is

      if (!(flags & DO_FOR_EACH_INCLUDE_BROKEN)) {
            if (entry->flag & REF_BROKEN)
                  return 0; /* ignore dangling symref */
            if (!has_sha1_file(entry->sha1)) {
                  error("%s does not point to a valid object!", entry->=
name);
                  return 0;
            }
      }

so if I understand correctly, for_each_ref would still allow one to
get away without unpacking the objects.  Is that correct?
