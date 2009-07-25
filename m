From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 02/10] gitweb: Mark boundary commits in 'blame' view
Date: Sat, 25 Jul 2009 02:32:27 +0200
Message-ID: <200907250232.28561.jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com> <1248475450-5668-3-git-send-email-jnareb@gmail.com> <7vocr94o2t.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 02:32:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUVBw-0005g8-8l
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 02:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbZGYAcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 20:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751714AbZGYAck
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 20:32:40 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:43722 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751256AbZGYAck (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 20:32:40 -0400
Received: by bwz28 with SMTP id 28so1702722bwz.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 17:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=VyQi6bgFoCog7oUYqPWA/ampiF73HmcDrifhW/crtCg=;
        b=QlYbMUunCetK9NNL2Z1vnYgFGilVw/pNulTy56A9khEaZc/UwtHRZhktNOiTI/Yqcc
         e4wWoWOlTXjbf1xkH2cHPbpe9Y7uLBzbNDll3Pr0iRyjugkArIJqvmoEjWItsOBlpMZ9
         2a39ztwmyJJOqekyy66389TPy5O/QrnCo6epU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=Lhc6OJeQ2e/Q6sm1Y8+uEAQ40qjgARk74z9uEFVCY3aBv4+aQyK7lGZow6zherHwob
         WaG87qhoGRMbMIPOilf+j6evosREe+vFEZ0+S3QzGmKGouE5t90kkwBN1WA8I1NKygyD
         dawqbPj97aHW48AnMeAwG0Opsu09SUyqZngmg=
Received: by 10.103.238.19 with SMTP id p19mr2045176mur.32.1248481957995;
        Fri, 24 Jul 2009 17:32:37 -0700 (PDT)
Received: from ?192.168.1.13? (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id 12sm15038386muq.23.2009.07.24.17.32.36
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 17:32:37 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vocr94o2t.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123985>

On Sat, 25 July 2009, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Use "boundary" class to mark boundary commits, which currently results
> > in using bold weight font for SHA-1 of a commit (to be more exact for
> > all text in the first cell in row, that contains SHA-1 of a commit).
> > ...
> > diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> > index 70b7c2f..f47709b 100644
> > --- a/gitweb/gitweb.css
> > +++ b/gitweb/gitweb.css
> > @@ -242,6 +242,10 @@ tr.dark:hover {
> >  	background-color: #edece6;
> >  }
> >  
> > +tr.boundary td.sha1 {
> > +	font-weight: bold;
> > +}
> > +
> 
> "boundary" means that "blame low..hight file" attributed the line to the
> "low" commit, not because the commit introduced the line, but because the
> user said not to bother digging further.

Well, currently 'blame' view in gitweb doesn't allow to limit revision
range from below, i.e. to state "low" commit; it doesn't use 'hpb' 
(hash_parent_base) parameter.  So boundary commit means root commit.

> 
> I had an assumption that in such a bounded blame, lines attributed to the
> boundary commit are not very interesting (they belong to a distant stable
> past that the user does not care much about, as opposed to more recent
> breakages), and that is exactly the same reasoning behind the -b option of
> "git blame" command.
> 
> I would have expected the boundary to be shown in weaker decoration
> (e.g. gray letters as opposed to black), not in stronger annotation.

Well, weaker decoration is, I think, actually harder to do in CSS...

> Perhaps you are talking about something different?  I am a bit puzzled.

Well, I have thought that only boundary commits can be without previous
[blame] commit, but I noticed that it is not the case: see 04/10.  But
some of that remains of my mistaken belief can resonate in commit 
message... ;-)

-- 
Jakub Narebski
Poland
