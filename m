From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Wed, 14 Jan 2009 13:06:56 -0500
Message-ID: <76718490901141006n6c70eb2cw67ad814b3739786e@mail.gmail.com>
References: <loom.20090113T145019-951@post.gmane.org>
	 <loom.20090113T185918-397@post.gmane.org>
	 <20090113203922.GD30404@atjola.homenet>
	 <loom.20090113T204616-845@post.gmane.org>
	 <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
	 <loom.20090113T211437-12@post.gmane.org>
	 <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com>
	 <loom.20090113T213400-985@post.gmane.org>
	 <76718490901131658l108852f2y9a25eb9133d6e96d@mail.gmail.com>
	 <loom.20090114T083207-942@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Eric Wong" <normalperson@yhbt.net>
To: "Vladimir Pouzanov" <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 19:08:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNAAO-0000tT-Vl
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 19:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbZANSG6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 13:06:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752979AbZANSG6
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 13:06:58 -0500
Received: from rv-out-0506.google.com ([209.85.198.236]:57211 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbZANSG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 13:06:57 -0500
Received: by rv-out-0506.google.com with SMTP id k40so634550rvb.1
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 10:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2Vrb/AaeJihjbJ7EMU9mkboekyS9s65gxvItBvNa6l8=;
        b=ShBBHhHKk7jNusdIO04BVSbJcUalRrekvWOkXE2RsFJl3degdZwOG6u/g+/KTBdBRp
         CqVcojJcN0MtCjiKdkiv9lhY41ikE5L8GoYXoK8fq3+oIpHCOofuVnfYb1hQsKMBkt8g
         4oZpsbdAoYpbrmxLinVlO/iMeqLRctoJzmI4U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=b4dkWyf0rpQL7iLuBfihjkusu/YIEC46QzaFNYM3TFLP6cwM53ksdNKfUqoppbaMW+
         O8ZNstM7OpRM5s3+PXmoBzUESdO9SK3Fz0PR/JZeP26surlihpa++krhu+gZ3KHg38K5
         z9B/7S3r6oHsbPfCyuteH2gUGgumwPAEPd1tA=
Received: by 10.141.37.8 with SMTP id p8mr116148rvj.227.1231956416221;
        Wed, 14 Jan 2009 10:06:56 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Wed, 14 Jan 2009 10:06:56 -0800 (PST)
In-Reply-To: <loom.20090114T083207-942@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105675>

On Wed, Jan 14, 2009 at 3:32 AM, Vladimir Pouzanov <farcaller@gmail.com> wrote:
> Jay Soffian <jaysoffian <at> gmail.com> writes:
>> So you're adding the "use Carp..." and "warn..." lines.
>>
>> Then try the import again. That should at least show why the svn_delta
>> temp file is being acquired twice.
>
> Output is pretty long so I've put in on pastebin:
> http://pastebin.com/m210be905

Okay, this is beyond me. git-svn (among other things) implements a
so-called delta editor (part of the subversion API). The driver for
that editor is apparently calling the editor's apply_textdelta()
method twice in a row w/o an intervening call to the editor's
close_file() method.

I don't understand when and/or why it would do this. This part of the
Subversion API seems not that well documented, and I got lost trying
to follow all the indirections in the Subversion source code (esp
w/the swig'ified Perl bindings). AFAICT, this should not be happening.

I could ask you to insert some more debugging statements to try to
track it to a specific file (or files), but I think at this point I'll
going to wait to see if the git-svn author has any ideas.

BTW, it doesn't help any that the order that files are checked out
seems not to be consistent. Not only is my git-svn clone working, the
order my files are checked out in is different from yours.

Oh, one other thing I don't understand is why the debugging output is
now showing that some files are being added for you (the lines
beginning with \tA). Before you weren't getting that. I had thought
these lines might be getting lost in stdout buffering, but git-svn
disables buffering on stdout, so color me confused.

Sorry I can't be more help,

j.
