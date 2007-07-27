From: Brett Schwarz <brett_schwarz@yahoo.com>
Subject: Re: git-gui-i18n: Make "Revert changes in these $n files" translatable.
Date: Thu, 26 Jul 2007 23:41:10 -0700 (PDT)
Message-ID: <53264.26898.qm@web38901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
To: Christian Stimming <stimming@tuhh.de>,
	Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>
X-From: git-owner@vger.kernel.org Fri Jul 27 08:41:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEJVn-00038B-7u
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 08:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761891AbXG0GlM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Jul 2007 02:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760840AbXG0GlM
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jul 2007 02:41:12 -0400
Received: from web38901.mail.mud.yahoo.com ([209.191.125.107]:46521 "HELO
	web38901.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755373AbXG0GlL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jul 2007 02:41:11 -0400
Received: (qmail 26902 invoked by uid 60001); 27 Jul 2007 06:41:11 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Mailer:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID;
  b=q7OTfOyzCut3ZE9bb/9G7q6rdHbR9Strdc2Iau6qWZq51CxN6buHJvnSH1aULIFiXxeSAZD72yKXLeJTQUgzbSTs2HsvjsPVnXJSS+ouH7zbBKf/6vk8gNeeN7JqCG1nC+jOhgn4n0XLyqUOHj23CepmloIfm+sQC7fmZPBneV8=;
X-YMail-OSG: h8i4I2oVM1kaIdo0hDehlLnJ0QA8euWftwkdGB6CYELk2uaOh3AC2E79j9n9VvQWD_u38tnJX4D2QiwjAYbQEz2zzlj7VlYXSgngPMVXLrGOkqU-
Received: from [128.251.88.135] by web38901.mail.mud.yahoo.com via HTTP; Thu, 26 Jul 2007 23:41:10 PDT
X-Mailer: YahooMailRC/651.41 YahooMailWebService/0.7.119
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53901>

> 
> 
> ----- Original Message ----
> From: Christian Stimming <stimming@tuhh.de>
> To: Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>
> Cc: Shawn O. Pearce <spearce@spearce.org>; Brett Schwarz <brett_schwarz@yahoo.com>; git@vger.kernel.org; Paul Mackerras <paulus@samba.org>; Junio C Hamano <gitster@pobox.com>
> Sent: Thursday, July 26, 2007 5:34:49 AM
> Subject: Re: git-gui-i18n: Make "Revert changes in these $n files" translatable.
> 
> Quoting Harri Ilari Tapio Liusvaara <hliusvaa@cc.hut.fi>:
> > On Thu, Jul 26, 2007 at 10:47:23AM +0200, Christian Stimming wrote:
> >> The issue with plural forms is even more complicated than that.
> >


<snip>

> > - Buttons in hard reset confirmation (branch->revert or merge->abort,
> >   and it is yes/no dialog).
> 
> I see this in translated form (German Ja/Nein), and also the button  
> text (translated or not) doesn't appear in the git-gui source code.  
> Maybe those need to be translated in the tcl/tk system libraries?
> 

These are indeed in the Tk libs. Unfortunately, there is no straight forward way to change the button text for tk_messageBox. I'll probably submit a patch to Tcl core for this.

In the mean time, if this is important, there are 2 ways around this:

1) override the button text in the msgcat. Tk does it's own msgcat internally (under the Tk namespace), and that's what prevents msgcat from changing these. You can see these under msgs directory where Tk is installed (/usr/local/tk8.4/msgs on my system). So, you would have to override for each language specified in that directory (if it warrants overriding). So, somewhere in the git-gui, you would have to do something like:
    namespace eval ::Tk {
      ::msgcat::mcset en_us &OK <new_term>
      ::msgcat::mcset en_us &Cancel <new_term>
      ::msgcat::mcset en_us &Yes <new_term>
      ::msgcat::mcset en_us &No <new_term>
      <continue for each language, if needed>
    }

2) Re-write the tk_messageBox, to include an option to specify the button text. This wouldn't be too hard actually, but this would live with git-gui.

I don't think option #1 is robust enough, but would be the easiest approach. Note also that this would only be for unix platforms, since for windows and Mac, it calls the platform's equivalent.

HTH,

    --brett






       
____________________________________________________________________________________
Building a website is a piece of cake. Yahoo! Small Business gives you all the tools to get online.
http://smallbusiness.yahoo.com/webhosting 
