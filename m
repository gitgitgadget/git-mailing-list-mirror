From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: shallow clone not very shallow due to tags
Date: Tue, 16 Aug 2011 00:00:09 +0100
Organization: OPDS
Message-ID: <4EEB129543344D0AA1C3AD3696F8F5D5@PhilipOakley>
References: <CAJo=hJuyZMj+qwFr_=stbQtGh2SCCpjfsBxm+2wbfJK=i_VTdw@mail.gmail.com> <CACsJy8DF49PJtv41vZEOX0fLg4U1+m6JEW28+iYD6jJxGctEzg@mail.gmail.com> <CAJo=hJv_NnZyGnedTQBL_mj3baS8O5Z2wiEbZCvv8305No4ehA@mail.gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "git" <git@vger.kernel.org>
To: "Shawn Pearce" <spearce@spearce.org>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 16 01:00:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qt68a-00089V-2X
	for gcvg-git-2@lo.gmane.org; Tue, 16 Aug 2011 01:00:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752075Ab1HOW76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Aug 2011 18:59:58 -0400
Received: from out1.ip09ir2.opaltelecom.net ([62.24.128.245]:55270 "EHLO
	out1.ip09ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807Ab1HOW76 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2011 18:59:58 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AtMAAOyjSU5Z8rUb/2dsb2JhbABBihWOM49NeIE7AQQBAQUIAQEuHgEBIQsCAwUCAQMOCgklFAEECBIGBxcGARIIAgECAwGHWQi7IIVoXwSHMJVYhwA
X-IronPort-AV: E=Sophos;i="4.67,376,1309734000"; 
   d="scan'208";a="487466901"
Received: from host-89-242-181-27.as13285.net (HELO PhilipOakley) ([89.242.181.27])
  by out1.ip09ir2.opaltelecom.net with SMTP; 15 Aug 2011 23:59:56 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6109
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179392>

Monday, August 15, 2011 6:16 PM "Shawn Pearce" <spearce@spearce.org>
> On Mon, Aug 15, 2011 at 07:03, Nguyen Thai Ngoc Duy <pclouds@gmail.com> 
> wrote:
>> On Mon, Aug 15, 2011 at 6:58 AM, Shawn Pearce <spearce@spearce.org> 
>> wrote:
>>> Uhm. That is not a very shallow clone. The clone copied 20234 objects
>>> at 9.15 MiB... so its ~20 MiB lighter than a full clone. But nearly
>>> all of the tags exist, because the clone client is declaring want
>>> lines for them, making the server generate up to 1 commit back from
>>> the wanted tag. I know shallow support is the feature nobody wants to
>>> think about, but this just seems broken to me. Clients performing a
>>> shallow clone shouldn't be asking for tags... but they should be using
>>> the include-tag protocol option so that if they do happen to receive a
>>> tagged commit, the tag object will also be sent.
>>
>> The same would apply if the repo in question has many branches. Should
>> we fetch only master (or a user-specified set of refs) in shallow
>> clone?
>
> Yes, I think a user who is making a shallow clone should only get the
> HEAD branch to the depth specified, nothing else. If they want
> additional branches, they should either pass them on the command line
> to a new flag for clone, or modify their fetch configuration
> after-the-fact and fetch those separately.
>
> From what I can gather from some users I have talked to, the primary
> usage of shallow clone is to try and (sort of) quickly grab a branch,
> make a change, and post that change to the maintainers for review and
> acceptance. E.g. correcting a spelling typo. Relatively simple changes
> that can be built on a specific branch, and don't really require all
> of the history.
>
> And if a repository does have more than one branch, but is shallow
> cloned at say depth of 1, the user probably doesn't get the merge
> bases between them, so the value of the other branches is greatly
> reduced. You can't make a merge between these, and a new developer
> getting involved in the project cannot see how the branches relate to
> each other. So there isn't a lot of value in sucking down those
> additional branches during clone.
>
The shallow clone problem came up a few times recently on StackOverflow. One 
usage is to create an orphan branch, but the manual doesn't point the user 
to that option. When I first read the man page I expected that any clone 
would be from a fixed point in history, rather than a point that may move 
(as extra commits are made to the remote). It maybe that what is needed is 
an option that will clone from a fixed commit point, so that there is no 
confusion as to the 'current depth'. 
