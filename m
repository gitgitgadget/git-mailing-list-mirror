From: "Jay Soffian" <jaysoffian@gmail.com>
Subject: Re: git-svn fails to fetch repository
Date: Tue, 13 Jan 2009 16:28:01 -0500
Message-ID: <76718490901131328x5ec30805u3cae29132defd695@mail.gmail.com>
References: <loom.20090113T145019-951@post.gmane.org>
	 <loom.20090113T150220-345@post.gmane.org>
	 <496CD49D.1070201@drmicha.warpmail.net>
	 <loom.20090113T185918-397@post.gmane.org>
	 <20090113203922.GD30404@atjola.homenet>
	 <loom.20090113T204616-845@post.gmane.org>
	 <76718490901131312j28f8283bi94f55000e70c532e@mail.gmail.com>
	 <loom.20090113T211437-12@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Vladimir Pouzanov" <farcaller@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 22:29:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMqpD-0003Si-It
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 22:29:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753018AbZAMV2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 16:28:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbZAMV2F
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 16:28:05 -0500
Received: from rv-out-0506.google.com ([209.85.198.226]:9792 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751771AbZAMV2D (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 16:28:03 -0500
Received: by rv-out-0506.google.com with SMTP id k40so184893rvb.1
        for <git@vger.kernel.org>; Tue, 13 Jan 2009 13:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=abM/7Ie+sR/6UBhd8IQ1C8IZzqAcFJ6GbKEeqOLHz5k=;
        b=sG1if+zRHgS+wAlV0fFtbfT5dNy9UM8AcgFz0Z/UOj/oER33FvRls1bkwVuZQbnQRt
         PqLkyksQYK7UOfkDw6jVtXshntz/mJ1tsIa3NDYkwWKm4aywblHNvqq6MRgbnl5pMQr+
         PehFiIw9X9U5EmXKXYTSWm3XRaQLqkT6rRGaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=GJisUbG9VNFsJocb32QuDGJdp3wuAFASTBIFPIAVtL3HHkiVRHS9cdenIuDmFdbhpj
         ivOUm/EbLwoxDkGteiGugN9XgqP2V57kkaymH3V9yVUbUVZKLvrj+jnAuyT/aL0vNI9Q
         IVd3/cH4BJ692ip7/11mGvx+DKAcLt1itpGU0=
Received: by 10.141.29.16 with SMTP id g16mr15456408rvj.287.1231882081914;
        Tue, 13 Jan 2009 13:28:01 -0800 (PST)
Received: by 10.140.204.11 with HTTP; Tue, 13 Jan 2009 13:28:01 -0800 (PST)
In-Reply-To: <loom.20090113T211437-12@post.gmane.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105538>

On Tue, Jan 13, 2009 at 4:16 PM, Vladimir Pouzanov <farcaller@gmail.com> wrote:
> Temp file with moniker ' at /opt/local/lib/perl5/site_perl/5.8.8/Git.pm line
> 1011.

Ah "throw Error::Simple(...)" w/multiple arguments does not work as
the caller thought. Can you manually edit
/opt/local/lib/perl5/site_perl/5.8.8/Git.pm and edit lines 1011 and
1012. So instead of:

                if ($TEMP_FILES{$$temp_fd}{locked}) {
                        throw Error::Simple("Temp file with moniker '",
                                $name, "' already in use");
                }

It will look like:

                if ($TEMP_FILES{$$temp_fd}{locked}) {
                        throw Error::Simple("Temp file with moniker '" .
                                $name . "' already in use");
                }

(i.e., replace the commas with dots.)

Perhaps this will help in tracking down the problem.

j.
