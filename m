From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Fri, 5 Jun 2009 09:24:42 +0200
Message-ID: <200906050924.43882.jnareb@gmail.com>
References: <200905122329.15379.jnareb@gmail.com> <200906042255.43952.jnareb@gmail.com> <20090605004540.GU3355@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 09:25:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCTnX-00077K-3j
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 09:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbZFEHY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 03:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbZFEHY5
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 03:24:57 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:56435 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbZFEHY4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 03:24:56 -0400
Received: by bwz9 with SMTP id 9so1279115bwz.37
        for <git@vger.kernel.org>; Fri, 05 Jun 2009 00:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Db8zAgWpxXsky3ED+hadd+tUAuGE+mkX+pYck5rvx4U=;
        b=JvPYuoGf2guyIRNGL5O7FndT6Ymk1oxZPFfD4t6xY95o5s0EZyCjHSNRgEIGplGNEQ
         MIkUIACbS+lk/o5A8ZiCTKiSl4IVDeCSHLzlMo5OmbxrDiZkyIDM8PnoqecQkI38fvDO
         dwiztXWzlf6TSly7mR1HfhWLBqZRAsKR3XMmE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=D6oUG1W9q0pwZRfQeN+QsYTOF1fwISjpYwWTGZVC4hYS9/57TN2AHD27J3cm9iBprw
         858HcuWRekMBkapd6QxVJPXH5dMmVccjpmjGp7kkfdB9lK3Fpv0WkzeK66gggZTkhR1T
         WaDP5ph2geyL9c78R//Y9ewAdHMxwuOpmaCys=
Received: by 10.103.246.1 with SMTP id y1mr1953845mur.120.1244186696925;
        Fri, 05 Jun 2009 00:24:56 -0700 (PDT)
Received: from ?192.168.1.13? (abvg76.neoplus.adsl.tpnet.pl [83.8.204.76])
        by mx.google.com with ESMTPS id n10sm2336841mue.17.2009.06.05.00.24.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 05 Jun 2009 00:24:55 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20090605004540.GU3355@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120758>

On Fri, 5 Jun 2009, Shawn O. Pearce wrote:
> Jakub Narebski <jnareb@gmail.com> wrote:
> > 
> > Here we were talking about the following part of exchange: 
> > (I have added "C:" prefix to signal that this is what client, 
> > git-clone here, sends; I have added also explicit "\n" to mark LF
> > characters terminating lines, and put each pkt-line on separate line)
> > 
> > gb>  C: 0054want 74730d410fcb6603ace96f1dc55ea6196122532d multi_ack side-band-64k ofs-delta\n
> > gb>  C: 0032want 7d1665144a3a975c05f1f43902ddaf084e784dbe\n
> > gb>  C: 0032want 5a3f6be755bbb7deae50065988cbfa1ffa9ab68a\n
> > gb>  C: 0032want 7e47fe2bd8d01d481f44d7af0531bd93d3b21c01\n
> > gb>  C: 0032want 74730d410fcb6603ace96f1dc55ea6196122532d\n
> > gb>  C: 0000
> > gb>  C: 0009done\n
> > 
> > and where server response is (again the quote from "Git Community Book"
> > was modified, removing here doublequotes and doubling of backslashes):
> 
> That should be fine.
> 
> Here's a dummy client that works against both jgit and C Git:
> 
>   perl -e '
> 	$h="fcfcfb1fd94829c1a1704f894fc111d14770d34e";
> 	$c="multi_ack side-band-64k ofs-delta";
>     sub w{$_=shift;printf "%4.4x%s",4+length,$_;}
>     w("git-upload-pack /.git");
>     w("want $h $c\n");
>     printf "0000";
>     w("done")
>   ' | nc localhost 9418
> 
> Are you sure you are flushing the IO buffers in the dummy client?

That is not what I meant. Perhaps I didn't explain it clear enough...

The above sequence works fine with dummy client in Perl; where it hangs
is when client tries to wait for server response (NAK or ACK) _before_
sending "done":

      $sock->print(pkt_line("want $h $c\n"));
      $sock->print("0000");
      $sock->flush();

      while (!$sock->eof()) {
        my $r = $sock->read($hex4, 4);  
        ...
      }

      $sock->print("0009done\n");
      $sock->flush();

But perhaps I did something wrong in my dummy client...


Also the flush "0000" seems to be required... but when I tried to repeat
it using the above example it actually does not hang, but doesn't get
PACK from git-daemon: there is something wrong in above snippet, as 
I get the same error on server whether I put "0000" flush line or not...

 c$  perl -e '
         my $h="c1e54552c9b35521f189db53db24cc82b5b75816";
         my $c="multi_ack side-band-64k ofs-delta";
         sub w{$_=shift;printf "%04x%s",4+length,$_;}
         w("git-upload-pack /git.git");
         w("want $h $c\n");
         ## printf "0000";    # <-- commented out!
         w("done");
     ' | nc localhost -v 9418
 
 s$  git daemon --export-all --verbose \
         --base-path=/home/local/scm/ /home/local/scm/
 [12791] Connection from 127.0.0.1:42484
 [12791] Request upload-pack for '/git.git'
 fatal: git upload-pack: not our ref c1e54552c9b35521f189db53db24cc82b5b75816 multi_ack side-band-64k ofs-delta

 [12692] [12791] Disconnected (with error)

-- 
Jakub Narebski
Poland
