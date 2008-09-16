From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 12:04:44 -0400
Message-ID: <32541b130809160904v7acc73cfm4856c33d40555e94@mail.gmail.com>
References: <loom.20080915T222909-709@post.gmane.org>
	 <48CF5B90.5050800@viscovery.net> <48CF630F.4090808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <j.sixt@viscovery.net>, git@vger.kernel.org
To: "Sergio Callegari" <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 18:06:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfd3r-0001fA-9n
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 18:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbYIPQEr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 12:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753187AbYIPQEr
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 12:04:47 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:55360 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbYIPQEq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 12:04:46 -0400
Received: by gxk9 with SMTP id 9so27728301gxk.13
        for <git@vger.kernel.org>; Tue, 16 Sep 2008 09:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=b3R5EB6diF97dyi1Frly2NSZpglgKHjXqcKTDYhBkpI=;
        b=o0dakzSxfiKPCmIywMR/QOCuKl8A5aKWJWQFDmJlnnD9DwDZWXEqOG3uMHkkejEmRP
         LUDYEmrj+e4epsQJA0MBA8vPMUJ4qkOpioLSRUoYfk5w48MRfdQVdvA+6XSIuT8wBO8V
         FMaEl+ChluOwBJqjazBhszd0YBGxJnA/nkKj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=D48u0py3h43tO7FENB1DbuQWpoQHJA6HUBR8k1kahsTKB2GRKCUh7iCRyWqU8nCpZi
         CAvAoDUhDWgW3BHK3H5tliXuRjQd3sHv8nLKJVgL0NYvEsu4Ka93h0fqddYprQwYxntm
         pPATON3EUJfoAtCr2rdNWwUYalGurWqQwLzsk=
Received: by 10.150.151.20 with SMTP id y20mr1730661ybd.172.1221581084312;
        Tue, 16 Sep 2008 09:04:44 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Tue, 16 Sep 2008 09:04:44 -0700 (PDT)
In-Reply-To: <48CF630F.4090808@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96013>

On Tue, Sep 16, 2008 at 3:41 AM, Sergio Callegari
<sergio.callegari@gmail.com> wrote:
> Johannes Sixt wrote:
>>
>> You don't need a temporay zip filename in filter mode:
>>
>>  unzip $UNZIP_OPTS /dev/stdin  # works for me, but not 100% portable
>>  zip $ZIP_OPTS - .             # writes to stdout
>>
>>
>
> The unzip documentation says "Archives read from standard input are not yet
> supported", so I was a bit worried about using the /dev/stdin thing.  Might
> it be that there are subtle cases where unzip needs to seek or rewind?

IIRC zip files keep their index at the end of the file, which means
zipping in a pipeline is efficient (you can write all the blocks
first, then drop the final index at the end) but unzipping that way is
really hard.

unzipping from /dev/stdin seems to work if stdin is seekable, otherwise not.

       unzip /dev/stdin <filename.zip    # works
       cat filename.zip | unzip /dev/stdin    # doesn't work

Have fun,

Avery
