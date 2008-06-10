From: Clark Williams <clark.williams@gmail.com>
Subject: Re: [PATCH - stgit] Patch to allow import of compressed files
Date: Tue, 10 Jun 2008 09:01:43 -0500
Message-ID: <484E8947.5070508@gmail.com>
References: <484D78BF.6030504@gmail.com>	 <20080610063328.GB26965@diana.vm.bytemark.co.uk>	 <alpine.DEB.1.10.0806092335420.17180@swallowtail> <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Asheesh Laroia <asheesh@asheesh.org>,
	=?UTF-8?B?S2FybCBIYXNzZWxzdHLDtg==?= =?UTF-8?B?bQ==?= 
	<kha@treskal.com>, Catalin Marinas <catalin.marinas@gmail.com>,
	git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jun 10 16:02:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K64Qv-0000q8-B0
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 16:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbYFJOBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 10:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753978AbYFJOBs
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 10:01:48 -0400
Received: from rv-out-0506.google.com ([209.85.198.224]:46597 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbYFJOBr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2008 10:01:47 -0400
Received: by rv-out-0506.google.com with SMTP id k40so907427rvb.1
        for <git@vger.kernel.org>; Tue, 10 Jun 2008 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=t5NxIQO4aLZWfe1ioaCfSnvpNKNuxfywJqwnENdja0E=;
        b=NjhVPvvsBp+hzyxKOXTcoU748xe/9lWfslnC4YnrrhKp1Er7amlhWEhJOlmQjeGKTJ
         7A2bUMXzc51AXw4ghDrER/cuqKQ4wUhr5LF5el1XZD1e7rxIuf3X9MeRXO2fi7uRpWZs
         VHQc2snKbRil5r1NE0AXPGJag8DYJd/D+SfWQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=o2DJn3Uv2qMh7rMoGqIxinenRbqUPJ7mIWtFiwCf/XWMoIBKB9Y5Uj/skKNLZ+ambE
         iqWgYjDLSwFMJ4Q/lQEcw9K2SmhwfovbSKMsb7jf1ok+H9+KCytbd/dhbGJPz3QkIdXg
         bU2NLVVOHzQdvya+fgMg70j2QVqvlDTbfoYm0=
Received: by 10.140.192.9 with SMTP id p9mr3010459rvf.114.1213106506454;
        Tue, 10 Jun 2008 07:01:46 -0700 (PDT)
Received: from ?192.168.2.37? ( [74.239.78.188])
        by mx.google.com with ESMTPS id 9sm1092730yws.5.2008.06.10.07.01.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Jun 2008 07:01:45 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (X11/20070911)
In-Reply-To: <bd6139dc0806100107y415a292eqe22af7a7b2215e65@mail.gmail.com>
X-Enigmail-Version: 0.95.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84504>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sverre Rabbelier wrote:
> On Tue, Jun 10, 2008 at 8:38 AM, Asheesh Laroia <asheesh@asheesh.org> wrote:
>> Peanut gallery question: Why not just always try these methods and catch
>> some format exception if they fail, proceeding to the next possible
>> decompressor (proceeding on to no decompressor)?
>>
>> That way if a file is called .GZ, it will still be handled properly; in
>> fact, all files would still be handled properly.  And these formats leave
>> notes in the first few bytes of the file as to if they should be tried, so
>> it's not as if it would come at some performance cost.
> 
> How about adding in '.tar' decompression as well, -after- the '.gz'
> decompression? That way you can have .tar.gz's and still be fine.
> 

I thought about this, as well as the .zip format. The problem is in multiple files
and how to handle them. Do you look for a series and automagically add '--series'
semantics? What about ignore/replace?  If no series file, do you just try to apply
all of them? In what order? Look for '.patch' suffix and only use those? And what
about the old '.tgz' suffix? Lots of different ways to go here.

I don't think it would be a bad thing to add .tar and .zip handling, but I'd rather
bat it around a little on this list before doing it. That way we can find out how
people would like to use it.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iEYEARECAAYFAkhOiUcACgkQqA4JVb61b9cWawCeK+n8uo8XGGlURYG2ImuhUUNY
eZEAn31ZfjC7MgiP1VZ02uksrRJQiQVe
=Tu6s
-----END PGP SIGNATURE-----
