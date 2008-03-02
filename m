From: "Ping Yin" <pkufranky@gmail.com>
Subject: Re: [PATCH v2 1/3] git-submodule: New subcommand 'summary' (1) - code framework
Date: Sun, 2 Mar 2008 13:11:45 +0800
Message-ID: <46dff0320803012111nfc1c005k51edfee4c4c75520@mail.gmail.com>
References: <1204306487-15849-1-git-send-email-pkufranky@gmail.com>
	 <80aa1c46ced6f0b92ca2fca3b917d383343b3161.1204306070.git.pkufranky@gmail.com>
	 <7vk5km7vir.fsf@gitster.siamese.dyndns.org>
	 <46dff0320803010227r5024d152g259a6a07a2441351@mail.gmail.com>
	 <7vejauxj38.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 06:12:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVgVL-0005aL-0y
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 06:12:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbYCBFLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 00:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbYCBFLr
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 00:11:47 -0500
Received: from an-out-0708.google.com ([209.85.132.249]:17075 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbYCBFLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 00:11:46 -0500
Received: by an-out-0708.google.com with SMTP id d31so1088113and.103
        for <git@vger.kernel.org>; Sat, 01 Mar 2008 21:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=P/DOgPKC5AlgfhGqTaxy8N3ZFVOJ+q4SQN4yKKLfe8M=;
        b=hYffI++YJEviuVnOpqRrIjDTOFuXaib0AVB0CqVuTQEx4w+86NojW73A7BguD+TWWjh7QfcD76FTTBkeUwZj6fHHlv6uwBwhoirdk11TGolEQ/+kqfsTQXPQpVBDv06NKQ9isKsixLYCX5d3NM5P8I40Tz/Ms311ypZeyxB8XYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PhRkoN7K1naSKnTvitUi4C/WHDUH99Wy1Gl7GHrSiErrYXBcoXqLHau2SoAfcGYCsYkj85Jt6aRrH7rsj6X0OwpCzBkYeS1H5nKa/pvFMfTFApRhvGZlKSZx1u0UXNMw9/iSLjNfms/WsdttkFxNouzSw3pc+aRJlls3WAWl2sA=
Received: by 10.100.189.10 with SMTP id m10mr24978444anf.76.1204434705575;
        Sat, 01 Mar 2008 21:11:45 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sat, 1 Mar 2008 21:11:45 -0800 (PST)
In-Reply-To: <7vejauxj38.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75720>

On Sun, Mar 2, 2008 at 4:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
> "Ping Yin" <pkufranky@gmail.com> writes:
>
>
>
> >>  > +             grep '^:160000\|:[0-9]\+ 160000' |
>  >>
>  >>  This looks troublesome.
>  >>
>  >>   - [0-9] is obviously wrong and [0-7] is what you meant;
>  >>   - \| and \+ are not BRE but GNU.
>  >>
>  > man grep says
>  >  In  basic regular expressions the metacharacters ?, +, {, |, (, and )
>  > lose their special meaning; instead use the backslashed versions \?,
>  > \+, \{, \|, \(, and \).
>  >
>  > Doen't it mean that '\|' is BRE ?
>
>  It just says unlike in ERE, these characters are not special in BRE; it
>  does not at all say using backslash like \?, \+, and \| makes them so.
>
>  And they are not.  \(...\), \{m\}, \{m,\} and \{m,n\} are part of BRE, but
>  the two you used (\+ and \|) are not.  GNU accept these two as extensions,
>  but other POSIX implementations may have troubles with them.
>
>   http://www.opengroup.org/onlinepubs/000095399/basedefs/xbd_chap09.html
>
>  Please be gentle to porters to non GNU systems.  Either stay inside BRE
>  (which I think we have managed to do with our usage of grep) or explicitly
>  ask for ERE with "grep -E".
>
ok, 3x.


-- 
Ping Yin
