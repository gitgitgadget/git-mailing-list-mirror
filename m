From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: clean/smudge filters for pdf files
Date: Fri, 24 Oct 2008 10:10:13 +0200
Message-ID: <490182E5.4030804@drmicha.warpmail.net>
References: <ee2a733e0810231244u1510cdc8y7b27af9b8fdda1e0@mail.gmail.com>	 <20081023213203.GB26104@artemis.corp> <ee2a733e0810231840u1aed8455w7e4c461e2565ad08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: SLONIK.AZ@gmail.com
X-From: git-owner@vger.kernel.org Fri Oct 24 10:11:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtHlf-0001Xx-Gv
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 10:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751756AbYJXIKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 04:10:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbYJXIKT
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 04:10:19 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:42827 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686AbYJXIKR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 04:10:17 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 99BCC17F915;
	Fri, 24 Oct 2008 04:10:15 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 24 Oct 2008 04:10:15 -0400
X-Sasl-enc: teo9sYj4h6W0u+mE1pl5eWOienwB9sZkUziE0M6Oup5L 1224835815
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id D6FBA302C3;
	Fri, 24 Oct 2008 04:10:14 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <ee2a733e0810231840u1aed8455w7e4c461e2565ad08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99019>

Leo Razoumov venit, vidit, dixit 24.10.2008 03:40:
> On 10/23/08, Pierre Habouzit <madcoder@debian.org> wrote:
>> On Thu, Oct 23, 2008 at 07:44:39PM +0000, Leo Razoumov wrote:
>>  > I am trying to improve storage efficiency for PDF files in a git repo.
>>  > Following earlier discussions in this list I am trying to set up
>>  > proper clean/smudge filters. What follows is my current setup
>>  >
>>  > # in ~/.gitconfig
>>  > [filter "pdf"]
>>  >       clean  = "pdftk - output - uncompress"
>>  >       smudge = "pdftk - output - compress"
>>  >
>>  > # in .gitattributes
>>  > *.pdf filter=pdf
>>  >
>>  > Unfortunately, it seems as though that pdftk uncompress followed by
>>  > pdftk compress do not leave the file invariant. I tried several
>>  > uncompress+compress iterations and the file still keep changing (the
>>  > size though stays the same).
>>  > Is there any other alternative way to store PDF files in git repo more
>>  > efficiently?
>>  > Any alternative to pdftk on Linux?
>>
>>
>> actually it uses some kind of zlib algorithm so that's pretty normal you
>>  don't have the same result with a packer. Maybe one could write a tool
>>  like pristine-tar for that purpose.
>>
> 
> With zlib you get the same deterministic result as long as you use the
> same zlib packer and unpacker. With pdftk compress/uncompress seem not
> to form a bijection pair. This issue was briefly discussed on this
> list back in April 2008 but no resolution emerged.

For a different file format I use the pair "gzip -c, gunzip -c" without
any problems, so zlib is not a problem. I do see the effect that
checkouts on different machines may have different compressed files
(same gzip version), but this is a non-issue.

Your experience with pdftk confirms mine. It shuffles things around
becauses it parses the files into objects and then writes them out again
in possibly different order. This is no problem for pdf because it uses
"pointers" (it's a bijection up to reordering), but it's a weird design,
and complicates things for us.

I'm still looking for something viable, I'll let list know when I've
found something...

Michael
