From: Tim Henigan <tim.henigan@gmail.com>
Subject: Re: [PATCH 8/9 v13] difftool: teach difftool to handle directory diffs
Date: Fri, 20 Apr 2012 12:58:18 -0400
Message-ID: <CAFouetiAgJzEhYFpXF5Tgr--VMRYqweQtn4t-QFvDBaDHDTQXg@mail.gmail.com>
References: <1334335002-30806-1-git-send-email-tim.henigan@gmail.com>
	<CAJDDKr7Uw3Nwg4p7F2zaY8f82j3_tRf3WiiO+YSN+nA6a9wY6w@mail.gmail.com>
	<CAJDDKr78T1HNFXPPnvMUxBoJhAHP8XGdk9ZbpQCS1sZEQJfR8w@mail.gmail.com>
	<CAFoueth37aeHMorh-r2w_mwSp+uSgeF+PYbUfHNPy9-HVvL01w@mail.gmail.com>
	<CAJDDKr6djdBvUbV6qZZu75iR2UbFHt8_D0+V+K_C+-Dgx8BfVA@mail.gmail.com>
	<CAFouetjbHewYzQXZr33xGKgwk0k7D8R0XfoP7k2qAV6Nq_d+Ow@mail.gmail.com>
	<7vsjg1knwr.fsf@alter.siamese.dyndns.org>
	<CAFouetgWpyUC9SPo_QwpESrbfib7ct111WesKPP14HQ+SqpFaQ@mail.gmail.com>
	<7v8vhsltk3.fsf@alter.siamese.dyndns.org>
	<CAFouetg6T1pgAiTfyAeSxseR-k_omsZDfqv8X8AifekwPLoE2g@mail.gmail.com>
	<xmqqy5prv9ol.fsf@junio.mtv.corp.google.com>
	<CAJDDKr7JtauR8sR3YC+wj60sx9DEgf87iaDwue2Cz6FzQX_Z+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <jch@google.com>, git@vger.kernel.org,
	ramsay@ramsay1.demon.co.uk
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 20 18:58:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLHA8-0001rB-VT
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 18:58:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857Ab2DTQ6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Apr 2012 12:58:20 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:64989 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753310Ab2DTQ6T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2012 12:58:19 -0400
Received: by iagz16 with SMTP id z16so13625748iag.19
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 09:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=8qkBk8lLF1GuOZ/0YXKxnCmaB1KDTNO3/8xAt7wDsVw=;
        b=mtJyvXfH5MLaI3AwjM6RgQcDa0qg2p5Pp20mOFz21zEILabCAFwrg+JzC9lT9qhq0e
         svkK42N73yvyAyaV7F0Jm+EaX8mnknOPWkL0oCvekJw+uwJ5RKPGCkJCSIazSi2+SHD7
         NXiVrxd9qNGBgP11zYVFBYLuv2aJ9mkZ6fByupf4D/U+u1PcqUG8B5CzKNsXF1Gh0/8o
         IVYv0sH+5qRX+XqW3dDvukZY3hVtKs9kf/s7tNokFuDiVJOmhN8kBGboiStlwH7EzzDG
         c7duqhX9kYaAe0GvkXDKu4Ec8XgAcP1H1lUoQk9I+ARXTtnXYWIFvOPlsTJ2otUQyiwi
         CvnQ==
Received: by 10.50.209.105 with SMTP id ml9mr7202316igc.23.1334941098847; Fri,
 20 Apr 2012 09:58:18 -0700 (PDT)
Received: by 10.42.225.193 with HTTP; Fri, 20 Apr 2012 09:58:18 -0700 (PDT)
In-Reply-To: <CAJDDKr7JtauR8sR3YC+wj60sx9DEgf87iaDwue2Cz6FzQX_Z+Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196008>

On Fri, Apr 20, 2012 at 3:34 AM, David Aguilar <davvid@gmail.com> wrote=
:
>
> An alternative would be teaching difftool to gracefully handle the R
> lines in the --raw output.
>
> Simply creating the files as they existed on each side is a reasonabl=
e
> start. =C2=A0It seems better form to handle all possible output from =
--raw
> anyways. =C2=A0It's better than pretending it doesn't exist, I think.

I like this idea best.  I will send v14 (lucky 14!) with this change.


> Doing "smart" things with the rename information is hairy so it's
> certainly worth leaving that for another day.

Agreed.
