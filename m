From: "Benjamin Sergeant" <bsergean@gmail.com>
Subject: Re: git-repack made my pack 317x larger...
Date: Fri, 15 Jun 2007 08:10:09 -0700
Message-ID: <1621f9fa0706150810m1d1bc31ua485db72f6e0bca1@mail.gmail.com>
References: <alpine.LFD.0.99.0706150935530.5651@xanadu.home>
	 <20070615145433.22970.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: nico@cam.org, git@vger.kernel.org
To: "linux@horizon.com" <linux@horizon.com>
X-From: git-owner@vger.kernel.org Fri Jun 15 17:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzDRZ-00047u-CN
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 17:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754049AbXFOPKN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 11:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbXFOPKM
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 11:10:12 -0400
Received: from nz-out-0506.google.com ([64.233.162.233]:8933 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbXFOPKK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 11:10:10 -0400
Received: by nz-out-0506.google.com with SMTP id n1so979116nzf
        for <git@vger.kernel.org>; Fri, 15 Jun 2007 08:10:09 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RTaBEKTjHa8CsVHJKCE1o3OzI7x9y5HLwSWRtsgr3Z6lMa1nEk4DEBk4qPup7w/Kk96oxMHtrLlW9BH4x4Uf8M5lQ9toUqw1z/en1fKrfHt/CeITywIraXvX+Q7MxOw+8pS5Nxl6rcfwi9VFS6HnFAn7qimMar4/v7iJRlpCnc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GCPtduRHRLWCtD44seDU85RfKKpQBCIFcACuZZ18TE8MCp1zlm4NjIMyK/bwcyztLQoF4laDJkmoPYUUkQMTMxAQDh/oH/9Xd3KjRbYQ1IHvO+lJLqe1gSPGI1FR0Tl2QCabtRj30x4FhG7hMjMdwM+JbduaPMb/reRUfNhByUQ=
Received: by 10.143.2.19 with SMTP id e19mr162633wfi.1181920209607;
        Fri, 15 Jun 2007 08:10:09 -0700 (PDT)
Received: by 10.142.108.1 with HTTP; Fri, 15 Jun 2007 08:10:09 -0700 (PDT)
In-Reply-To: <20070615145433.22970.qmail@science.horizon.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50266>

> (I might complan a little less if git-repack would take -adlf rather
> than insisting on -a -d -l -f.  Is that a deliberate choice or has just
> nobody stepped up to revamp the option parsing?)

getopt is our friend, indeed.

(http://www.hmug.org/man/1/getopt.php)

The following code fragment shows how one might process the arguments for
     a command that can take the options -a and -b, and the option -o, which
     requires an argument.

           args=`getopt abo: $*`
           # you should not use `getopt abo: "$@"` since that would parse
           # the arguments differently from what the set command below does.
           if [ $? != 0 ]
           then
                   echo 'Usage: ...'
                   exit 2
           fi
           set -- $args
           # You cannot use the set command with a backquoted getopt directly,
           # since the exit code from getopt would be shadowed by those of set,
           # which is zero by definition.
           for i
           do
                   case "$i"
                   in
                           -a|-b)
                                   echo flag $i set; sflags="${i#-}$sflags";
                                   shift;;
                           -o)
                                   echo oarg is "'"$2"'"; oarg="$2"; shift;
                                   shift;;
                           --)
                                   shift; break;;
                   esac
           done
           echo single-char flags: "'"$sflags"'"
           echo oarg is "'"$oarg"'"

     This code will accept any of the following as equivalent:

           cmd -aoarg file file
           cmd -a -o arg file file
           cmd -oarg -a file file
           cmd -a -oarg -- file file
