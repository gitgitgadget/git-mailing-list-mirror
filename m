From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: RFD: git-bzr: anyone interested?
Date: Fri, 19 Feb 2010 15:55:49 +0200
Message-ID: <20100219135549.GA31796@Knoppix>
References: <4B7D8358.1080108@gmail.com>
 <fabb9a1e1002181037n58d6942dpa63a57a23f506d9c@mail.gmail.com>
 <4B7E3856.3080609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 19 14:56:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiTKx-0000aj-Od
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 14:56:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752544Ab0BSNzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 08:55:54 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:51789 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab0BSNzx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 08:55:53 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 533F38C368;
	Fri, 19 Feb 2010 15:55:52 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A07221404FB; Fri, 19 Feb 2010 15:55:52 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 271B3E51C0;
	Fri, 19 Feb 2010 15:55:50 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <4B7E3856.3080609@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140451>

On Fri, Feb 19, 2010 at 02:05:58AM -0500, Gabriel Filion wrote:
> 
> The Documentation/git-remote-helpers.txt file wasn't really of much help
> .. It really only barely scratches the subject, but it does not mention
> how remote-helpers really work internally (e.g. how do they get called:
> based on protocol used in URLs?)
> 
> I'm still trying to dig up information about how to actually build, test
> and use a remote helper. I'll probably be reading code for examples.

The remote helper is invoked with one or two parameters. 

There are five cases to consider (as rule, first argument is name of
remote [pseudo-remote in case URL was used] and the second argument is
URL to use, if any):

1) Remote <remote> without URL line but with VCS line value <helper> was used.

The called program: git-remote-<helper>  [search $PATH for it].
Number of arguements: 1
1st argument: <remote>

2) Remote <remote> with URL using <helper>::<string> syntax was used.

The called program: git-remote-<helper>  [search $PATH for it].
Number of arguments: 2
1st argument: <remote>
2st argument: <string>

3) Remote <remote> with URL using <helper>://<rest-of-URL> syntax was used.

The called program: git-remote-<helper>  [serch $PATH for it].
Number of arguments: 2
1st argument: <remote>
2st argument: <helper>://<rest-of-URL>

4) URL using <helper>::<string> syntax was used directly on command line.

The called program: git-remote-<helper>  [serch $PATH for it].
Number of arguments: 2
1st argument: <helper>::<string>
2st argument: <string>

5) URL using <helper>://<rest-of-URL> syntax was used directly on command
line.

The called program: git-remote-<helper>  [serch $PATH for it].
Number of arguments: 2
1st argument: <helper>://<rest-of-URL>
2st argument: <helper>://<rest-of-URL>


Notes:

- For 2) and 4), the helper name can only contain alphanumeric characters
  0-9, A-Z and a-z.
- For 3) and 5), the helper name can't be any of builtin protocols:
  'rsync', 'file', 'git', 'ssh', 'git+ssh' nor 'ssh+git'.
- <helper>::<string> is the strongest, followed by VCS line,
  <helper>:://<rest-of-URL> is weakest.

-Ilari
