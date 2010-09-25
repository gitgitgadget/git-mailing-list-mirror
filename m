From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC/PATCH 0/3] fast-import: give importers access to the
 object store
Date: Fri, 24 Sep 2010 19:01:56 -0500
Message-ID: <20100925000156.GA23735@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100817170216.GA14491@kytes>
 <20100905031528.GA2344@burratino>
 <1284596048.3298.3.camel@wilber>
 <20100924194313.GA8114@burratino>
 <AANLkTinsotbGpg1LAXA+UchBHQrBK12tkX+o4tOFWUOF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 02:04:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzIG6-00056p-6j
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 02:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab0IYAEt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 20:04:49 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:45756 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab0IYAEs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 20:04:48 -0400
Received: by gyd8 with SMTP id 8so1153636gyd.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 17:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=BoCAPsTmKA05tGjtybKa1UthhpS1K5rm2t0i9DMwmpk=;
        b=GUVxPzKEnlPKahnSVFbJ/yIz+UTisxGpRbILut0+cwiUuxivvlUvHGEBGWGe27nemk
         4yJFEizFqt50t4a7WOvo60thlUZi80ae5mLznRmGZroP49Zv1SiRG/Oy2+6vaen9P92O
         Y992SH9wdLdrbf4nR1leqIuGLBX3i7WrbBDP0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h7LF0qiV9LqN6NVdEDPPjldbr0FMP/937rlzkMNgmDKW4bjj3iK6dw8HIYAajqFkbZ
         p2jW72nGqREduxOU/hjEI/whdfRBBDyG7VpSe51jdTLIxFhr0zizZMLwXBnWORpNMjpR
         aclPCmvaUgtqw515K4NltrlLqGt1i4YVW428s=
Received: by 10.101.180.40 with SMTP id h40mr4783063anp.50.1285373087487;
        Fri, 24 Sep 2010 17:04:47 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id u14sm4167609ann.0.2010.09.24.17.04.45
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 17:04:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinsotbGpg1LAXA+UchBHQrBK12tkX+o4tOFWUOF@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157104>

Sverre Rabbelier wrote:
> On Fri, Sep 24, 2010 at 21:43, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Yes, I guess "feature report-fd=3" is a protocol layering violation.
>> Unfortunately import-marks and export-marks have already set a
>> precedent.
>
> I don't agree, they (can) use a relative path name, allow the stream
> to be re-used at a different location.

Sorry, I had confused myself.  Especially with relative-marks, using
relative paths without worrying about where they point makes a lot
of sense.  I was thinking of a frontend that reads or writes the marks
file itself, but import/export-marks features can also be used to just
save/restore marks opaquely.

(So iiuc one could imagine a backend that writes the marks within a
table somewhere instead of a text file when relative-marks is
requested, and most frontends could cope with that.)

Thus I have no precedent to fall back on. :)

>> Well-behaved streams could use that and rely on the fd to be set on
>> the command line, while poorly-behaved streams could still use
>> "feature report-fd=whatever" to get the effect of --report-fd=whatever
>> and avoid breaking UI consistency.
>
> Additionally you could have the commandline override whatever the
> stream sets, so that the stream can be re-used as long as the user
> specifies the appropriate commandline arguments?

Yep, that would work.  Still I don't think it makes a lot of sense to
allow "feature report-fd=4" in the fast-import stream.  If I can
ensure that fast-import has file descriptor 4 mapped to the right
place, then I am in control of the process that starts fast-import, so
a command-line option would be easy enough to use, no?
