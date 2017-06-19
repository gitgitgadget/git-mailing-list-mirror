Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEA61FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 20:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdFSUOB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 19 Jun 2017 16:14:01 -0400
Received: from mail.plc2.de ([212.43.91.138]:58675 "EHLO mail.plc2.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbdFSUOA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 16:14:00 -0400
Received: from SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb]) by
 SBS2011.opfingen.plc2.de ([fe80::48e5:6c6d:d5a9:75eb%10]) with mapi id
 14.01.0438.000; Mon, 19 Jun 2017 22:13:58 +0200
From:   Patrick Lehmann <Patrick.Lehmann@plc2.de>
To:     Stefan Beller <sbeller@google.com>
CC:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailinglist <git@vger.kernel.org>
Subject: AW: Restoring detached HEADs after Git operations
Thread-Topic: Restoring detached HEADs after Git operations
Thread-Index: AdLo2JTYy82hS69wTnuiUW9EIL+4M///6qaAgAAkeNWAAFK+gIAAL/wm///jxgCAACeMAP//8q4AgAArZeY=
Date:   Mon, 19 Jun 2017 20:13:57 +0000
Message-ID: <0092CDD27C5F9D418B0F3E9B5D05BE0801028CD6@SBS2011.opfingen.plc2.de>
References: <0092CDD27C5F9D418B0F3E9B5D05BE08010287DF@SBS2011.opfingen.plc2.de>
 <88AC6179-75D6-416B-9235-C628D6C59CA5@gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE080102887B@SBS2011.opfingen.plc2.de>
 <CAGZ79kY0gwk7KRY2iAVTXPBjPzx+mkciVWRR2z2cDgiBjQ2uuw@mail.gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE0801028A86@SBS2011.opfingen.plc2.de>
 <CAGZ79kbMOdkKiVsvxk4UeKKPicyi958LpomeY=ypXT0_=5d8BQ@mail.gmail.com>
 <0092CDD27C5F9D418B0F3E9B5D05BE0801028B70@SBS2011.opfingen.plc2.de>,<CAGZ79kYB__LOK5MhK_OrXYL1xYgYW0Hk5XfjYfRWAcH_AJ78uQ@mail.gmail.com>
In-Reply-To: <CAGZ79kYB__LOK5MhK_OrXYL1xYgYW0Hk5XfjYfRWAcH_AJ78uQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [109.42.2.129]
x-g-data-mailsecurity-for-exchange-spamlevel: 0
x-g-data-mailsecurity-for-exchange-state: 0
x-g-data-mailsecurity-for-exchange-error: 0
x-g-data-mailsecurity-for-exchange-sender: 32
x-g-data-mailsecurity-for-exchange-server: 70cd0149-74d1-4df2-bc08-c934d48ac3c3
x-g-data-mailsecurity-for-exchange-guid: 14366CE4-0BB8-43FA-ABFC-2DE2AECAD355
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Stefan,

I never have tapped into the DLL Hell trap. That's maybe I never did C++ development or I started with VB .NET / C# as .NET solved major parts of the DLL Hell :). That doesn't mean my new beloved language Python doesn't have a similar problem ...


Thinking about DLL Hell is a thinking in big version numbers like 1.0, 2.0 oder even 2.1, 2.2, ...
We are here talking about revisions in the build numbers which need to be synchronized between the parent repository and the sub modules (IP cores). Both sides are under heavy development and interfaces evolving from day to day because hardware design can't be planned as easy as software design.

So by using Git submodules a developer - responsible for a submodule / IP core - can after he finished interface level 1 now go on and implement interface level 2. The parent project can finish it's integration and testing of the level 1 interface before proceeding with level 2. More over if the same IP core is used multiple time in different sub IP cores, it's possible to update one usage place to interface level 2 by a second developer so he can finish his IP core at level 2, which other usage places can still use the level 1 interface.

Start situation:
--------------------------------------
TOPLEVEL (developer A)
  o- IP_1 @level1 (developer B)
       o- IP_2 @level1 (developer C)
  o- IP_3 @level1 (developer D)
       o- IP_2 @level1


Developer C creates interface level 2, but all instances use level1 of IP_2:
--------------------------------------
TOPLEVEL (developer A)
  o- IP_1 @level1 (developer B)
       o- IP_2 @level1 (developer C)
  o- IP_3 @level1 (developer D)
       o- IP_2 @level1


Developer D updates instance of IP_2 to level 2 and completes level 2 of IP_3:
--------------------------------------
TOPLEVEL (developer A)
  o- IP_1 @level1 (developer B)
       o- IP_2 @level1 (developer C)
  o- IP_3 @level1 (developer D)
       o- IP_2 @level2

Developer A updates instance of IP_3 to level 2:
--------------------------------------
TOPLEVEL (developer A)
  o- IP_1 @level1 (developer B)
       o- IP_2 @level1 (developer C)
  o- IP_3 @level2 (developer D)
       o- IP_2 @level2

Developer B has finished his testing for IP_1 and can now update the instance if IP_2:
--------------------------------------
TOPLEVEL (developer A)
  o- IP_1 @level1 (developer B)
       o- IP_2 @level2 (developer C)
  o- IP_3 @level2 (developer D)
       o- IP_2 @level2


So now imaging 8 developers, whereof 6 are working remote on the project. There is one responsible developer per IP core (maintainer) and an overall maintainer overseeing all integration merges and test results (CI).


Kind regards
    Patrick

________________________________________
Von: Stefan Beller [sbeller@google.com]
Gesendet: Montag, 19. Juni 2017 21:21
Bis: Patrick Lehmann
Cc: Lars Schneider; Git Mailinglist
Betreff: Re: Restoring detached HEADs after Git operations

On Mon, Jun 19, 2017 at 11:09 AM, Patrick Lehmann
<Patrick.Lehmann@plc2.de> wrote:
> Hello Stefan,
>
> the use case is as follows:
>
> The projects consists of circa 18 IP cores. Each IP core is represented by a Git repository. Think of an IP core as of a lonestanding DLL or SO file project. Each IP core references 2 submodules, which bring the verification environments for testing the IP core standalone.

So phrased differently: You are using submodules to avoid "DLL hell"
(sharing a lib, with ease of versioning as the submodules in the different IP
cores may be pointing at different versions).

>
> These 18 IP cores are grouped to bigger IP cores, referencing the low-level IP cores and each again the 2 verification submodules. Finally, the main project references the bigger IP cores and again the 2 verification cores.
>
> TOPLEVEL
>   o- IP1
>        o- UVVM
>        o- VUnit
>   o- IP2
>        o- UVVM
>        o- VUnit
>   o- IP3
>        o- UVVM
>        o- VUnit
>   o- IP4
>        o- UVVM
>        o- VUnit
>        o- IP5
>            o- UVVM
>            o- VUnit
>        o- IP6
>            o- UVVM
>            o- VUnit
>        o- IP7
>            o- UVVM
>            o- VUnit
>   o- IP8
>        o- UVVM
>        o- VUnit
>        o- IP9
>            o- UVVM
>            o- VUnit
>        o- IP10
>            o- UVVM
>            o- VUnit
>   o- IP11
>        o- UVVM
>        o- VUnit
>        o- IP9
>            o- UVVM
>            o- VUnit
>        o- IP12
>            o- UVVM
>            o- VUnit
>    o- UVVM
>    o- VUnit
>
> That's the simplified structure. I can't write more, because it's a closed source project. You can find other usecases e.g. in my other open source projects. E.g. The PoC-Library or The PicoBlaze-Library and the corresponding PoC-Examples repository.
>
> Example: PoC
> Pile of Cores includes 4 Git submodules and is itself an IP core library.
> So PoC-Examples again references PoC. This looks like this tree:
>
> PoC-Examples
>   |- lib/
>        o- PoC
>             |- lib
>                 o- Cocotb
>                 o- OSVVM
>                 o- VUnit
>                      o- .... OSVVM
>                 o- UVVM
>
> The library VUnit itself already includes OSVVM as a library.
>
> ----------------------
> Forcast:
> I'll write a new question / idea about multiple equal submodules and the memory footprint soon...
> Here is my original question posted on StackOverflow: https://stackoverflow.com/questions/44585425/how-to-reduce-the-memory-footprint-for-multiple-submodules-of-the-same-source
> ----------------------
>
> Do you need more use cases?
>

Well this use case points out a different issue than I hoped for. ;)
From the stackoverflow post and from looking at the layout here,
one of the major questions is how to deduplicate the submodule
object store for example.

By use case I rather meant a sales pitch for your initial email:

    I use this bash script because it fits in my workflow because
    I need branches instead of detached HEADS, because $REASONS

and I'd be interested in these $REASONS, which I assumed to be
* easier to work with branches than detached HEADS (it aids the workflow)
* we're not challenging the underlying mental model of tracking sha1s in
  the superproject rather than branches.

At least I gave these reasons in the "reattach HEAD" stuff that I wrote,
but maybe there are others? (I know the code base of submodules very
well, but I do not work with submodules on a day-to-day basis myself...)
