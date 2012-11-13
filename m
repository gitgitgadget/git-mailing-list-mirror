From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [BUG] gitweb: XSS vulnerability of RSS feed
Date: Tue, 13 Nov 2012 18:22:56 +0100
Message-ID: <CANQwDwcNXPhA3Qe2K_GLuh3F8DObDQ+Wn_PHhTkJqM+4D+SK0w@mail.gmail.com>
References: <20121111232820.284510@gmx.net> <CAM9Z-n=6xsC7yiKJ+NU-CxNPxEXWmJzvXLUocgZgWPQnuK6G4Q@mail.gmail.com>
 <20121112202413.GD4623@sigill.intra.peff.net> <CAM9Z-nkuHj8MWLfWsvY=EqHXCUS+Pk5Ezv6m5J+cnh7cQHNc_g@mail.gmail.com>
 <20121113170452.GE20361@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Drew Northup <n1xim.email@gmail.com>,
	glpk xypron <xypron.glpk@gmx.de>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	"Jason J Pyeron CTR (US)" <jason.j.pyeron.ctr@mail.mil>,
	Andreas Schwab <schwab@linux-m68k.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 13 18:23:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYKD1-00080k-56
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 18:23:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187Ab2KMRXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 12:23:21 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:50063 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932172Ab2KMRXS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 12:23:18 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so439887obb.19
        for <git@vger.kernel.org>; Tue, 13 Nov 2012 09:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hPdQ4A9yB9we0AlOEpHf0b0PIh8AuwwQyROuuoTV3NY=;
        b=fU9O5BNKZc9iYmkdlqo/4jXQhCEJZ+AZfPBuG5KqSZxLIgTKpa3aKPCSxB+EAEKSRm
         7iCYL73ac2Iz90psj5SFdY5mlZ7b/5f9xsEAGIgQKS14ro6aBvZN/XXJtgC1dAE0b+DA
         IuxZ9M2uwGzRzLCmesSMRVAdoSGl4ssYV6+b+5NVVItgexkP3sxIByd+lW3GZHQMxkUH
         ua8lb+0TECQBPs2U63iQAnw5uZhheHWObqJHm5hrUi1F6+rv50mlRzzNaDBxtTIDQbKd
         HfGKQ4+LE94WHqzv1ygdSBBHg85Xlbj7uNxNucKHDbdmVN66/5161v3GoCMJNJNK/jPG
         kRyQ==
Received: by 10.60.14.198 with SMTP id r6mr17404045oec.115.1352827398268; Tue,
 13 Nov 2012 09:23:18 -0800 (PST)
Received: by 10.76.91.134 with HTTP; Tue, 13 Nov 2012 09:22:56 -0800 (PST)
In-Reply-To: <20121113170452.GE20361@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209644>

On Tue, Nov 13, 2012 at 6:04 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Nov 13, 2012 at 09:44:06AM -0500, Drew Northup wrote:

>> Besides, inserting one call to esc_html only fixes one attack path. I
>> didn't look to see if all others were already covered.
>
> Properly quoting output is something that the web framework should do
> for you. gitweb uses CGI.pm, which does help with that, but we do not
> use it consistently. If there are other problematic areas, I think the
> best path forward is to use our framework more.

Well, calling CGI.pm a _framework_ is overly generous, but it does
include some HTML generation subroutines / methods, and gitweb
makes use of them, especially $cgi->a() for links.

But it cannot help in this case, because here we are generating XML:
RSS or Atom feed. There was proposal some time ago to switch
to using XML::FeedPP or XML::Atom::Feed + XML::RSS::Feed for
feed generation.

Perhaps it is high time to switch to some Perl web (micro)framework,
like Dancer, Mojolicious or Catalyst... but not requiring extra modules
has its advantages (and there always exist Gitalist).
-- 
Jakub Narebski
